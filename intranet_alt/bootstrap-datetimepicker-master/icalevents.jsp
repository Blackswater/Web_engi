  {  
            string iCal =  
  
            "BEGIN:VCALENDAR" +  
  
            "\nPRODID:-//SampleApp//AoT//EN" +  
  
            "\nVERSION:2.0" +  
            /// REQUEST for add or update, CANCEL for cancellation  
            "\nMETHOD:" + methodType +  
  
            "\nBEGIN:VEVENT" +  
  
            "\nORGANIZER:CN='Matt'" +  
  
            //"\nORGANIZER:MAILTO:matt.balent@anvil-of-time.com" +  
  
            "\nATTENDEE;CN='" + cnAttendee + "'" +  
  
            ";ROLE=REQ-PARTICIPANT;RSVP=TRUE;CN=" + userEmailAddress +   
  
            "\nDTSTART:" + startDateTime.ToUniversalTime().ToString(_dateFormat) +  
  
            "\nDTEND:" + endDateTime.ToUniversalTime().ToString(_dateFormat) +  
  
            "\nSTATUS:CONFIRMED" +  
  
            "\nTRANSP:OPAQUE" +  
            /// 0 for add, 1 for update or cancellation  
            "\nSEQUENCE:" + seqNo +  
  
            "\nUID:" + Guid.NewGuid() +  
            /// resend original UID for updates and cancellations  
            //"\nUID:" + UID +  
  
            "\nDTSTAMP:" + createdOn.ToUniversalTime().ToString(_dateFormat) +  
  
            "\nLAST-MODIFIED:" + createdOn.ToUniversalTime().ToString(_dateFormat) +  
  
            "\nLOCATION:" + location +  
  
            "\nDESCRIPTION:" + notes +  
  
            "\nSUMMARY:" + emailSubject +  
  
            "\nPRIORITY:5" +  
  
            "\nCLASS:PUBLIC" +  
  
            "\nEND:VEVENT" +  
  
            "\nEND:VCALENDAR";  
  
            return iCal;
	    }