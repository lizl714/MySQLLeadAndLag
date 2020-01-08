/* Example using lead and lag */
-- DROP TABLE test.playlist;
CREATE TABLE test.playlist (
  `playlist_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  play_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  user_id INT(11) DEFAULT NULL,
  artist_id INT(11) DEFAULT NULL,
  track_id INT(11) DEFAULT NULL,
  PRIMARY KEY (`playlist_id`)
) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

INSERT INTO test.`playlist`
(user_id, artist_id, track_id)
VALUES
(1,1,1),
(1,2,1),
(1,3,1),
(1,1,2),
(1,1,3),
(1,1,4),
(1,2,4),
(1,3,4),
(1,4,4),
(1,2,1),
(1,2,2),
(1,2,3),
(1,3,3),
(1,4,3);

SELECT curr_artist
FROM (
SELECT artist_id AS curr_artist, lead(artist_id)
 over (ORDER BY playlist_id) AS prev_artist
 , lag(artist_id,1) over (ORDER BY playlist_id) AS next_artist
FROM test.`playlist`) s
WHERE curr_artist = prev_artist AND curr_artist = next_artist;
