package com.chimerasys;

import com.chimerasys.Tag;
import com.chimerasys.User;
import java.util.Collection;
import java.sql.Timestamp;
import java.sql.Date;

/*
mysql> desc events;
+-------------+--------------+------+-----+---------------------+-----------------------------+
| Field       | Type         | Null | Key | Default             | Extra                       |
+-------------+--------------+------+-----+---------------------+-----------------------------+
| id          | int(11)      | NO   | PRI | NULL                | auto_increment              |
| name        | varchar(128) | YES  |     | NULL                |                             |
| dtstart     | timestamp    | NO   |     | CURRENT_TIMESTAMP   | on update CURRENT_TIMESTAMP |
| dtend       | timestamp    | NO   |     | 0000-00-00 00:00:00 |                             |
| ownerid     | int(11)      | YES  |     | NULL                |                             |
| alarmmin    | int(11)      | YES  |     | NULL                |                             |
| status      | varchar(16)  | YES  |     | NULL                |                             |
| location    | varchar(80)  | YES  |     | NULL                |                             |
| repeattype  | varchar(1)   | YES  |     | NULL                |                             |
| repeatuntil | date         | YES  |     | NULL                |                             |
| comment     | text         | YES  |     | NULL                |                             |
| url         | varchar(128) | YES  |     | NULL                |                             |
+-------------+--------------+------+-----+---------------------+-----------------------------+
*/

public class Event {
	
    private final int id;
    private String name;
    private User owner;
    private Collection<Tag> tags;
    private Timestamp dtStart;
    private Timestamp dtEnd;
    private Timestamp creationDate;
    private Timestamp deletionDate;
    private int alarmMin; // minutes of alarm, 0=off
    private String status;
    private String location;
    private char repeatType;
    private Date repeatUntil;
    private String comment;
    private String url;
    
    public Event(int id) {
	this.id = id;
    }
    
    public int getId() {
	return id;
    }
    
    public String getName() {
	return this.name;
    }
    
    public void setName(String name) {
	this.name = name;
    }
    
    public String getComment() {
	return this.comment;
    }
    
    public String getUrl() {
	return this.url;
    }
    
    public void setUrl(String u) {
	this.url = u;
    }
    
    public void setComment(String c) {
	this.comment = c;
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

    public void setStartdate(java.sql.Timestamp t) {
	this.dtStart = t;
    }
    
    public void setEnddate(java.sql.Timestamp t) {
	this.dtEnd = t;
    }
    
    public void setCreationdate(java.sql.Timestamp t) {
	this.creationDate = t;
    }
    
    public void setDeletiondate(java.sql.Timestamp t) {
	this.deletionDate = t;
    }
    
}
