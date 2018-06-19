package com.chimerasys;

import com.chimerasys.Tag;
import com.chimerasys.User;
import java.util.Collection;
import java.sql.Timestamp;

/*
mysql> desc documents;
+--------------+-------------+------+-----+-------------------+----------------+
| Field        | Type        | Null | Key | Default           | Extra          |
+--------------+-------------+------+-----+-------------------+----------------+
| id           | int(11)     | NO   | PRI | NULL              | auto_increment |
| name         | varchar(64) | YES  |     | NULL              |                |
| filename     | varchar(64) | YES  |     | NULL              |                |
| ownerid      | int(11)     | YES  |     | NULL              |                |
| creationdate | timestamp   | NO   |     | CURRENT_TIMESTAMP |                |
| archivedate  | timestamp   | YES  |     | NULL              |                |
| deletiondate | timestamp   | YES  |     | NULL              |                |
| sha256       | varchar(64) | YES  |     | NULL              |                |
| mimetype     | varchar(32) | YES  |     | NULL              |                |
| bytelength   | int(11)     | YES  |     | NULL              |                |
+--------------+-------------+------+-----+-------------------+----------------+
*/

public class Document {
	
    private final int id;
    private String name;
    private String filename;
    private User owner;
    private Collection<Tag> tags;
    private Timestamp creationDate;
    private Timestamp archiveDate;
    private Timestamp deletionDate;
    private String sha256;
    private String mimetype;
    private int bytelength;
    
    public Document(int id) {
	this.id = id;
    }
    
    public int getId() {
	return id;
    }
    
    public String getName() {
	return this.name;
    }
    
    public void setName(String firstname) {
	this.name = firstname;
    }
    
    public String getFilename() {
	return this.filename;
    }
    
    public void setFilename(String lastname) {
	this.filename = lastname;
    }

    public User getOwner() {
	return this.owner;
    }
    
    public void setOwner(User u) {
	this.owner = u;
    }

    public Collection<Tag> getTags() {
	return this.tags;
    }
    
    public void setTags(Collection<Tag> t) {
	this.tags = t;
    }

    public void setCreationdate(java.sql.Timestamp t) {
	this.creationDate = t;
    }
    
    public void setArchivedate(java.sql.Timestamp t) {
	this.archiveDate = t;
    }
    
    public void setDeletiondate(java.sql.Timestamp t) {
	this.deletionDate = t;
    }
    
    public void setMimetype(String s) {
	this.mimetype = s;
    }

    public void setBytelength(int b) {
	this.bytelength = b;
    }

}
