package com.boat.domain;

import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Data
public class Filelike {

	private int FLIKE_NO;
	private int FILE_NUM;
	private String EMPNO;
	private	int FILEBO_LIKE;
	private Date REG_DATE;
}
