
	SELECT * FROM (
			SELECT rownum rnum, J.* FROM(
				SELECT * FROM(
					SELECT b.BOARD_NUM, b.BOARD_SUBJECT, b.BOARD_DEPT, b.BOARD_NAME, b.BOARD_READCOUNT, b.BOARD_DATE, b.BOARD_NOTICE, NVL(CNT, 0) AS CNT  
					FROM BOARD b LEFT OUTER JOIN  (SELECT board_num, COUNT(*) AS cnt FROM comments
											GROUP BY board_num) c
					ON b.BOARD_NUM = c.board_num
					where BOARD_EMPNO =  #{empno}
						UNION ALL
					SELECT FILE_NUM, FILE_SUBJECT, DEPT, FILE_NAME, FILE_READCOUNT, FILE_DATE, FILE_FILE, NVL(CNT, 0) AS CNT
					FROM file_board  LEFT OUTER JOIN (SELECT FILE_BO_NUM, COUNT(*) CNT  from FILE_COMMENT
					GROUP BY FILE_BO_NUM)
					ON FILE_NUM = FILE_BO_NUM
					where FIlE_EMPNO = #{empno}
				)
				ORDER BY BOARD_DATE DESC
			) J
			where rownum <= #{end}
		)
		where rnum >= #{start} and rnum <= #{end}

SELECT * FROM (
			SELECT rownum rnum, J.* FROM(
				SELECT * FROM(
					SELECT b.BOARD_NUM, b.BOARD_SUBJECT, b.BOARD_DEPT, b.BOARD_NAME, b.BOARD_READCOUNT, b.BOARD_DATE, b.BOARD_NOTICE, NVL(CNT, 0) AS CNT  
					FROM BOARD b LEFT OUTER JOIN  (SELECT board_num, COUNT(*) AS cnt FROM comments
											GROUP BY board_num) c
					ON b.BOARD_NUM = c.board_num
					where BOARD_EMPNO = #{empno}
						UNION ALL
					SELECT FILE_NUM, FILE_SUBJECT, DEPT, FILE_NAME, FILE_READCOUNT, FILE_DATE, FILE_FILE, NVL(CNT, 0) AS CNT
					FROM file_board  LEFT OUTER JOIN (SELECT F_BO_NUM, COUNT(*) CNT FROM Filecomm
					GROUP BY F_BO_NUM)
					ON FILE_NUM = F_BO_NUM
					where FIlE_EMPNO = 
				)
				ORDER BY BOARD_DATE DESC
			) J
			where rownum &lt;= 
		where rnum &gt;= and rnum &lt;= 






SELECT * FROM (
    SELECT A.*, ROWNUM RN FROM (
        SELECT file_board.*, NVL(cnt, 0) AS cnt, 
               LISTAGG(fbf.FILE_NUM, ',') WITHIN GROUP
                (ORDER BY fbf.FILE_NUM) AS abc
        FROM file_board 
        LEFT OUTER JOIN (
            SELECT F_COMMENT_NUM, COUNT(*) AS cnt  
            FROM FILE_COMMENT  
            GROUP BY F_COMMENT_NUM
        ) c ON file_board.FILE_NUM = c.F_COMMENT_NUM   
        LEFT OUTER JOIN filebo_fav fbf ON file_board.FILE_NUM = fbf.FILE_NUM 
         GROUP BY file_board.FILE_NUM, file_board.FILE_NAME,
         file_board.FILE_SUBJECT, file_board.FILE_CONTENT,
          file_board.FILE_PASS, 
          file_board.FILE_FILE, 
          file_board.FILE_FILE2, 
          file_board.DEPT, 
          file_board.FILE_ORIGINAL2, 
          file_board.FILE_ORIGINAL, 
          file_board.FILE_DATE, file_board.FILE_READCOUNT, 
          file_board.FILE_RE_REF, file_board.FILE_RE_LEV, 
          file_board.FILE_RE_SEQ, file_board.FILE_EMPNO,
            cnt
        ORDER BY file_board.FILE_RE_REF DESC, file_board.FILE_RE_SEQ ASC
    ) A
    WHERE ROWNUM <= 10
) 
WHERE RN >= 1;

                --    " + asc//desc + , 등록순, 최신순

select F_C_NUM, FILE_COMMENT.F_C_ID, F_CONTENT, F_COMMENT_DATE, F_COMMENT_RE_LEV, 
				   F_COMMENT_RE_SEQ, F_COMMENT_RE_REF, member.memberfile 
				   from FILE_COMMENT join member 
				   on FILE_COMMENT.F_C_ID = member.empno 
				   where F_COMMENT_NUM = ? 
				   order by F_COMMENT_RE_REF 
                   <if test='state=="1"'>
                   asc,
                   </if>
                   <if test='state=="1"'>
                   desc,
                   </if>

				   		 F_COMMENT_RE_SEQ asc