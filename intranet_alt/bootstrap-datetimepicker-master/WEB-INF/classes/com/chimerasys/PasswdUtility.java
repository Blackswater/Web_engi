package com.chimerasys;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Arrays;
import java.util.Base64;

public class PasswdUtility {
	private static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	
	public PasswdUtility() {
	}
	
    /** create random password for user's use */
    public String getRandomPwd(int len) throws NoSuchAlgorithmException {
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
	    StringBuilder sb = new StringBuilder( len );
	    for( int i = 0; i < len; i++ ) {
		sb.append( AB.charAt( random.nextInt(AB.length()) ) );
	    }
	    return sb.toString();
	}
	
    /** @return base64-encoded 64-bit (8byte) secure-random salt */
    public static byte[] mkSalt() throws NoSuchAlgorithmException {
	System.err.println("Tick1");
            // Uses a secure Random not a simple Random
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
	System.err.println("Tick2");
            // Salt generation 64 bits long
            byte[] bSalt = new byte[8];
	System.err.println("Tick3");
            random.nextBytes(bSalt);
	System.err.println("Tick4");
            return bSalt;
    }

    /** @return base64-encoded password hash for a given password and salt (see method above) */
    public static byte[]  hashPasswd(String passwd, byte [] salt) throws NoSuchAlgorithmException, UnsupportedEncodingException {
	System.err.println("tick hp1");
	return getHash(10, passwd, salt);
    }

    public String addUserPasswdHashById(int id, String password) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        if (password != null) {
            // Uses a secure Random not a simple Random
            SecureRandom random = SecureRandom.getInstance("SHA1PRNG");
            // Salt generation 64 bits long
            byte[] bSalt = new byte[8];
            random.nextBytes(bSalt);
            // Digest computation
            byte[] bDigest = getHash(10, password, bSalt);
            String sDigest = byteToBase64(bDigest);
            String sSalt = byteToBase64(bSalt);
	    return new String(bDigest);
        }
	return null;
    }
	
    /**
     * From a password, a number of iterations and a salt,
     * returns the corresponding digest
     * @param iterationNb int The number of iterations of the algorithm
     * @param password String The password to encrypt
     * @param salt byte[] The salt
     * @return byte[] The digested password
     * @throws NoSuchAlgorithmException If the algorithm doesn't exist
     * @throws UnsupportedEncodingException 
     */
    public static byte[] getHash(int iterationNb, String password, byte[] salt) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        MessageDigest digest = MessageDigest.getInstance("SHA-1");
        digest.reset();
        digest.update(salt);
        byte[] input = digest.digest(password.getBytes("UTF-8"));
        for (int i = 0; i < iterationNb; i++) {
            digest.reset();
            input = digest.digest(input);
        }
        return input;
    }
    
    /**
     * From a base 64 representation, returns the corresponding byte[] 
     * @param data String The base64 representation
     * @return byte[]
     * @throws IOException
     */
    public static byte[] base64ToByte(String data) throws IOException {
        return Base64.getDecoder().decode(data);
    }
  
    /**
     * From a byte[] returns a base 64 representation
     * @param data byte[]
     * @return String
     * @throws IOException
     */
    public static String byteToBase64(byte[] data){
        return new String(Base64.getEncoder().encodeToString(data));
    }
    
    /**
     * Authenticates the user with a given login and password
     * If password and/or login is null then always returns false.
     * If the user does not exist in the database returns false.
     * @param login String The login of the user (cleartext)
     * @param passhash base64 encoded password hash (as in DB)
     * @param salt base64 encoded salt (as in DB)
     * @param password String The password of the user (cleartext)
     * @return true, if authentication successful
     * @throws NoSuchAlgorithmException If the algorithm SHA-1 is not supported by the JVM
     */
    public boolean authenticate(String login, String passhash, String salt, String password)
            throws NoSuchAlgorithmException {

        try {
            boolean userExist = true;
            // INPUT VALIDATION
            if (login == null || passhash == null || salt == null || password == null) {
                // TIME RESISTANT ATTACK
                // Computation time is equal to the time needed by a legitimate user
                userExist = false;
                login = "";
                password = "";
		salt = "";
		passhash = "";
            }
            
            byte[] bDigest = Base64.getDecoder().decode(passhash);
            byte[] bSalt   = Base64.getDecoder().decode(salt);
  
            // Compute the new DIGEST
            byte[] proposedDigest = getHash(10, password, bSalt);
  
            return (Arrays.equals(proposedDigest, bDigest) && userExist);
        } catch (Exception ex) {
	    return false;
        }
    }
}
