package com.boat.Service.Attandance;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boat.domain.Attandance;
import com.boat.mybatis.mapper.AttandanceMapper;

@Service
public class AttandanceServiceImpl implements AttandanceService {

	private static final Logger logger = LoggerFactory.getLogger(AttandanceServiceImpl.class);
	private AttandanceMapper dao;
	// private LogAdvice log;

	@Autowired
	public AttandanceServiceImpl(AttandanceMapper dao) {
		this.dao = dao;
	}

	@Override
	public List<Attandance> getAttList() {
		return dao.getAttList();
	}

	// 개인 리스트가져오기(여러날)
	@Override
	public List<Attandance> getAttList(String eMPNO) {
		logger.info(eMPNO);
		return dao.getAttList(eMPNO);
	}

	@Override // (당일)
	public Attandance getTodayMyatt(String EMPNO) {

		return dao.getTodayMyatt(EMPNO);
	}

	@Override
	public void AttOn(String on, String EMPNO, String DEPT, String NAME) {
		dao.AttOn(on, EMPNO, DEPT, NAME);

	}

	@Override
	public void AttOff(String OFF_TIME, String EMPNO) throws ParseException {

		Attandance att = new Attandance();
		att.setOFF_TIME(OFF_TIME);
		att.setEMPNO(EMPNO);
		// 퇴근시간 업데이트
		dao.AttOff(att);
		String ON_TIME = att.getON_TIME();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd H:m");
		Date stt = sdf.parse(ON_TIME);
		Date ett = sdf.parse(OFF_TIME);
		long sttseconds = stt.getTime() / 1000;
		long ettseconds = ett.getTime() / 1000;
		long todaywork = ettseconds - sttseconds;

		// 초를 시간과 분으로 변환
		long hours = todaywork / 3600;
		long minutes = (todaywork % 3600) / 60;

		// 시간과 분을 HH:mm 형식의 문자열로 변환
		String WORK_TIME = String.format("%02d:%02d", hours, minutes);

		logger.info("시작시간 stt..............." + stt);
		logger.info("종료시간 ett..............." + ett);
		logger.info("시작시간 초로변환............." + sttseconds);
		logger.info("종료시간 초로변환................" + ettseconds);

		logger.info("초단위 todaywork" + todaywork);

		logger.info("오늘 일한시간" + WORK_TIME);
		dao.Todayworktime(WORK_TIME, EMPNO);
	}

	private CellStyle getHeaderCellStyle(Workbook workbook) {
		CellStyle headerCellStyle = workbook.createCellStyle();
		headerCellStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		headerCellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		headerCellStyle.setAlignment(HorizontalAlignment.CENTER);
		headerCellStyle.setBorderTop(BorderStyle.THIN);
		headerCellStyle.setBorderBottom(BorderStyle.THIN);
		headerCellStyle.setBorderLeft(BorderStyle.THIN);
		headerCellStyle.setBorderRight(BorderStyle.THIN);
		headerCellStyle.setWrapText(true);

		return headerCellStyle;
	}

	private CellStyle getBodyCellStyle(Workbook workbook) {
		CellStyle bodyCellStyle = workbook.createCellStyle();
		bodyCellStyle.setBorderTop(BorderStyle.THIN);
		bodyCellStyle.setBorderBottom(BorderStyle.THIN);
		bodyCellStyle.setBorderLeft(BorderStyle.THIN);
		bodyCellStyle.setBorderRight(BorderStyle.THIN);
		bodyCellStyle.setWrapText(true);

		return bodyCellStyle;
	}

	// 출퇴근 리스트 엑셀파일 다운로드
	@Override
	public void getExceldata(Attandance att, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// dept 받아서 부서별 엑셀다운
		// String dept = getDEPT()
		// List<Attandance> alllist = dao.getAttList();
		List<Attandance> list = dao.getAttList(att.getEMPNO());

		SXSSFWorkbook wb = new SXSSFWorkbook();
		Sheet sheet = wb.createSheet();
		sheet.setColumnWidth((short) 0, (short) 2000);
		sheet.setColumnWidth((short) 1, (short) 5000);
		sheet.setColumnWidth((short) 2, (short) 3000);
		sheet.setColumnWidth((short) 3, (short) 8000);
		sheet.setColumnWidth((short) 4, (short) 8000);
		sheet.setColumnWidth((short) 5, (short) 5000);
		sheet.setColumnWidth((short) 6, (short) 5000);

		Row row = sheet.createRow(0);
		Cell cell = null;
		CellStyle cs = wb.createCellStyle();
		Font font = wb.createFont();
		cell = row.createCell(0);
		cell.setCellValue("근태관리-출퇴근 목록");
		getHeaderCellStyle(wb);
		sheet.addMergedRegion(new CellRangeAddress(row.getRowNum(), row.getRowNum(), 0, 6));

		row = sheet.createRow(1);
		cell = null;
		cs = wb.createCellStyle();
		font = wb.createFont();

		cell = row.createCell(0);
		cell.setCellValue("번호");
		getHeaderCellStyle(wb);

		cell = row.createCell(1);
		cell.setCellValue("출근 날짜");
		getHeaderCellStyle(wb);

		cell = row.createCell(2);
		cell.setCellValue("이름");
		getHeaderCellStyle(wb);

		cell = row.createCell(3);
		cell.setCellValue("시작 시간");
		getHeaderCellStyle(wb);

		cell = row.createCell(4);
		cell.setCellValue("종료 시간");
		getHeaderCellStyle(wb);

		cell = row.createCell(5);
		cell.setCellValue("당일 총 근무시간");
		getHeaderCellStyle(wb);

		cell = row.createCell(6);
		cell.setCellValue("부서명");
		getHeaderCellStyle(wb);

		int i = 2;
		int ii = list.size();
		for (Attandance attlist : list) {

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd H:m");
			String st = attlist.getON_TIME();
			Date stt = sdf.parse(st);
			String et = attlist.getOFF_TIME();
			Date ett = sdf.parse(et);
			logger.info(stt.toLocaleString());

			// String startTime = sdf.format();
			// String endTime = sdf.format();

			row = sheet.createRow(i);
			cell = null;
			cs = wb.createCellStyle();
			font = wb.createFont();

			cell = row.createCell(0);
			cell.setCellValue(ii);

			cell = row.createCell(1);
			cell.setCellValue(attlist.getREG_DATE().substring(0, 11));

			cell = row.createCell(2);
			cell.setCellValue(attlist.getNAME());

			cell = row.createCell(3);
			cell.setCellValue(stt.toLocaleString());

			cell = row.createCell(4);
			cell.setCellValue(ett.toLocaleString());

			cell = row.createCell(5);
			cell.setCellValue(attlist.getWORK_TIME());

			cell = row.createCell(6);
			cell.setCellValue(attlist.getDEPT());

			i++;
			ii--;
		}

		response.setHeader("Set-Cookie", "fileDownload=true; path=/");
		response.setHeader("Content-Disposition", String.format("attachment; filename=\"Attendacelist.xlsx\""));
		wb.write(response.getOutputStream());

	}

	@Override
	public String[] thisweekwork(String firstWeekDay, String lastWeekDay, String EMPNO) throws ParseException {
		System.out.println("==========================================");
		Map<String, String> map = new HashMap<>();
		map.put("firstWeekDay", firstWeekDay);
		map.put("lastWeekDay", lastWeekDay);
		map.put("EMPNO", EMPNO);

		Attandance att = new Attandance();
		att.setTotal_work_time(dao.thisweekwork(map));
		String total_work_time = att.getTotal_work_time();

		System.out.println(total_work_time);
		String time = "";
		
		if(total_work_time.equals(":")) {
			time = "00:00";}
		
		float timeper = 0;
		
		if (total_work_time != null && !total_work_time.equals(":")) {
			int minutes = Integer.parseInt(total_work_time.split(":")[0]); // 분 단위로 파싱
			int hours = minutes / 60; // 시간으로 변환
			timeper = Math.round(((float)minutes/2100)*100);
			int remainingMinutes = minutes % 60; // 분 단위로 남은 값 계산
			System.out.println(timeper + "1200000000000123456");
			
			time = String.format("%02d:%02d", hours, remainingMinutes); // 시간 형태로 변환
		}
		System.out.println(time + "123456"); // 1:54 출력
		String timeperr = timeper+"%";
		String [] timelist = {time,timeperr };
		return timelist;

	}

}
