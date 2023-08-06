package com.boat.Task;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.stereotype.Service;

import com.boat.Service.FileboService.FileBoService;
import com.boat.domain.MySaveFolder;

@Service
@EnableScheduling
@Configuration//
public class FileCheckTask {

	private static final Logger logger = LoggerFactory.getLogger(FileCheckTask.class);

	@Autowired
	private MySaveFolder mysavefolder;//230313
	
	@Autowired
	private FileBoService boardservice;

	//@Scheduled(fixedDelay=1000)
	public void test() throws Exception{
		logger.info("test");
	}
	
	
	//CRON사용법
	//seconds(초:0~59) minutes(분 : 0~59) hours(시:0~23) day(일:1~31)
	//months(달:1~12) day of week(요일:0~6) year(optional)
	//				초 분 시 일 달 요일	
	//@Scheduled(cron = "30 * * * * *")
	public void checkFiles() throws Exception{
		String saveFolder= mysavefolder.getSavefolder();//230313
		
		logger.info("checkFiles");
		List<String> deleteFileList = boardservice.getDeleteFileList();
		
		
		for(int i = 0; i<deleteFileList.size(); i++) {
			String filename = deleteFileList.get(i);
			
			File file =new File(saveFolder + filename);
			if(file.exists()) {
				
				if(file.delete()) {
					logger.info(file.getPath()+" 삭제되었습니다.");
					boardservice.deleteFileList(filename);
				}
			}else {
				logger.info(file.getPath()+ " 파일이 존재하지 않습니다.");
			}
		}
	}
}
