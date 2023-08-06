package com.boat.controller.member;


import java.io.File;
import java.io.PrintWriter;
import java.security.Principal;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boat.Service.ChatMessageService;
import com.boat.Service.MemberService;
import com.boat.Task.SendMail;
import com.boat.domain.Board;
import com.boat.domain.ChatMessage;
import com.boat.domain.MailVO;
import com.boat.domain.Member;
import com.boat.sns.NaverLoginBO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	private static final Logger Logger = LoggerFactory.getLogger(MemberController.class);
 
	private MemberService memberservice;
	private NaverLoginBO naverloginbo;//네이버 api
	private SendMail sendMail;
	private PasswordEncoder passwordEncoder;
	private ChatMessageService chatmessageservice;
	
	@Autowired
	private JavaMailSenderImpl mailSender; 
	
	
	@Autowired
	public MemberController(MemberService memberservice, NaverLoginBO naverloginbo, 
			SendMail sendMail, PasswordEncoder passwordEncoder, JavaMailSender javaMailSender,
			ChatMessageService chatmessageservice) {
		this.memberservice = memberservice;
		this.naverloginbo = naverloginbo;
		this.sendMail = sendMail;
		this.passwordEncoder = passwordEncoder;
		this.chatmessageservice = chatmessageservice;
	}

	
	//회원가입
	@GetMapping(value = "/sign_up")
	public String signUp(Model model,HttpSession session) {
		String naverAuthUrl = naverloginbo.getAuthorizationUrl(session);
		model.addAttribute("naverUrl", naverAuthUrl);
		Logger.info("naverAuthUrl="+naverAuthUrl);
		return "/Member/sign_up";
	}
	
	//일반 회원가입 => 정보 작성폼
	@GetMapping(value = "/join")
	public String join(@RequestParam("email") String email, Model model, HttpSession session) {
		
		model.addAttribute("email", email);
		return "/Member/joinForm";
	}
	
	//사원번호 생성
	@RequestMapping(value = "/idcheck", method = RequestMethod.GET)
	public void join(@RequestParam("select") String select, HttpServletResponse response, 
			RedirectAttributes rattr) throws Exception {
		Logger.info("select="+select);
		int empno = memberservice.isEmpno(select);
		System.out.println("empno="+empno);
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(empno);
		
	}
	
	//회원가입 처리
	@RequestMapping(value = "/joinProcess", method = RequestMethod.POST)
	public String joinProcess(Member member, RedirectAttributes rattr,
								Model model, HttpServletRequest request) throws Exception {
		member.setPASSWORD_OG(member.getPASSWORD());
		
		//비밀번호 암호화 추가
		String encPassword = passwordEncoder.encode(member.getPASSWORD());
		Logger.info(encPassword);
		member.setPASSWORD(encPassword);
		
		
		MultipartFile uploadfile = member.getUploadfile();
		
		if(!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();//원래 파일명
			
			String saveFolder = new File("src/main/resources/static/profile").getAbsolutePath();
//			String saveFolder= profileSaveFolder.getProfilesavefolder();
			List<String> fileDBName = fileDBName(fileName, saveFolder, member.getEMPNO());
			Logger.info("fileDBName : " + fileDBName);
			
			String fileDBNames = fileDBName.get(0);
			String refileName = fileDBName.get(1);
			
			//transferTo(file path) : 업로드된 파일을 매개변수의 경로에 저장합니다.
			uploadfile.transferTo(new File(saveFolder + fileDBNames));
			Logger.info("transferTo path : " + saveFolder + fileDBNames);
			//바뀐 파일명으로 저장
			member.setPROFILE_IMG(refileName);
			Logger.info("fileDBNames : " + fileDBNames);
			
			System.out.println("absolutePathss " +saveFolder);
			//파일 경로 이름
			member.setPROFILE_FILE("profile" + fileDBNames);
		}
		
		
		int result = memberservice.insert(member);
		System.out.println("result="+result);
		//result=0;
		/*
		 * 스프링에서 제공하는 RedirectAttributes는 기존의 Servlet에서 사용되던
		 * response.sendRedirect()를 사용할 때와 동일한 용도로 사용합니다.
		 * 리다이렉트로 전송하면 파라미터를 전달하고자 할 때 addAttribute()나 addFlashAttribute()를 사용합니다.
		 * 예) response.sendRedirect("/test?result=1");
		 * => rattr.addAttribute("result",1)
		 */
				
		//삽입이 된 경우
		if(result == 1) {
			MailVO vo = new MailVO();
			vo.setTo(member.getEMAIL());
			vo.setContent(member.getEMPNO() + "님 회원 가입을 축하드립니다.");
			sendMail.sendMail(vo);
			
			rattr.addFlashAttribute("result", "joinSuccess");
			return "redirect:sign_in";
		}else {
			model.addAttribute("url", request.getRequestURI());
			model.addAttribute("message","회원 가입 실패");
			
			return "error/error";
		}
	}
	
	//파일명
	private List<String> fileDBName(String fileName, String saveFolder, String empno) {
		//새로운 폴더 이름 : 오늘 년+월+일
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);//오늘 년도 구합니다.
		int month = c.get(Calendar.MONTH) + 1;//오늘 월 구합니다.
		int date = c.get(Calendar.DATE);//오늘 일 구합니다.
		
		String homedir = saveFolder + "/" + year + "-" + month + "-" + date;
		Logger.info(homedir);
		File path1 = new File(homedir);
		if(!(path1.exists())) {
			path1.mkdir();//새로운 폴더를 생성
		}
		
		
		/*** 확장자 구하기 시작 ***/
		int index = fileName.lastIndexOf(".");
		/*
		 * 문자열에서 특정 문자열의 위치 값(index)을 반환합니다.
		 * IndexOf가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
		 * lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환합니다.
		 * (파일명에 점에 여러개 있을 경우 맨 마지막에 발견되는 문자열의 위치를 리턴합니다.)
		 */
		Logger.info("index = " + index);
		
		String fileExtenstion = fileName.substring(index + 1);
		Logger.info("fileExtenstion = " + fileExtenstion);
		/*** 확장자 구하기 끝 ***/
		
		//새로운 파일명
		String refileName = empno + "." + fileExtenstion;
		Logger.info("refileName = " + refileName);
		
		//오라클 디비에 저장될 파일명
		//String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
		String fileDBName = File.separator + year + "-" + month + "-" + date + File.separator + refileName;
		Logger.info("fileDBName = " + fileDBName);
		
		List<String> fileNames = new ArrayList<String>();
		fileNames.add(fileDBName);
		fileNames.add(refileName);
		
		return fileNames;
	}
	
	
	//이메일 인증
	@ResponseBody
	@RequestMapping(value = "/emailAuth", method = RequestMethod.POST)
	public String emailAuth(String email) {	
		System.out.println("전달받은 이메일:"+email);
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		/* 이메일 보내기 */
        String setFrom = "dmswjddid37@naver.com";
        String toMail = email;
        String title = "BOAT 회원가입 인증 이메일 입니다.";
        String content = 
                "BOAT 홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + " 입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        return Integer.toString(checkNum);
 
	}
	
	
	
	
	
	
	
	
	
	
	//네이버 회원가입 => 정보 작성폼
	@RequestMapping(value = "/naverlogin", method = {RequestMethod.GET,RequestMethod.POST})
	public String userNaverLoginPro(Model model,@RequestParam Map<String,Object> paramMap, @RequestParam String code, 
			@RequestParam String state,HttpSession session, RedirectAttributes rattr) throws SQLException, Exception {
		System.out.println("paramMap:" + paramMap);
		Map <String, Object> resultMap = new HashMap<String, Object>();
		
		
		OAuth2AccessToken oauthToken = naverloginbo.getAccessToken(session, code, state);
		
		//로그인 사용자 정보를 읽어온다.
		String apiResult = naverloginbo.getUserProfile(oauthToken);
		System.out.println("apiResult =>"+apiResult);
		
		ObjectMapper objectMapper =new ObjectMapper();
		Map<String, Object> apiJson = (Map<String, Object>) objectMapper.readValue(apiResult, Map.class).get("response");
		System.out.println("apiJson="+apiJson);
		
		Map<String, Object> naverConnectionCheck = memberservice.naverConnectionCheck(apiJson);
		System.out.println("naverConnectionCheck="+naverConnectionCheck);
		
		if(naverConnectionCheck == null) { //일치하는 이메일 없으면 가입
			
			model.addAttribute("email",apiJson.get("email"));
			model.addAttribute("id",apiJson.get("id"));
			model.addAttribute("name",apiJson.get("name"));
			System.out.println("apiJson.get(\"id\")="+apiJson.get("id"));
			return "/Member/joinForm2";
			
		}
		else { //모두 연동 되어있을시
			Map<String, Object> loginCheck = memberservice.userNaverLoginPro(apiJson);
			System.out.println("loginCheck="+loginCheck);
			session.setAttribute("userInfo", loginCheck);
			
			String EMPNO = (String) loginCheck.get("EMPNO");
			String PASSWORD_OG = (String) loginCheck.get("PASSWORD_OG");
			session.setAttribute("EMPNO", EMPNO);
			session.setAttribute("PASSWORD_OG", PASSWORD_OG);
			
			return "redirect:sign_in";
		}
		
	}
	
	//네이버 회원가입 처리
	@RequestMapping(value="/userNaverRegisterPro", method=RequestMethod.POST)
	public String userNaverRegisterPro(@RequestParam Map<String,Object> paramMap,HttpSession session, RedirectAttributes rattr,
			@RequestParam String PASSWORD, @RequestParam MultipartFile uploadfile, Model model, HttpServletRequest request) throws SQLException, Exception {
		System.out.println("paramMap=" + paramMap);
		
		//비밀번호 암호화 추가
		String encPassword = passwordEncoder.encode(PASSWORD);
		Logger.info(encPassword);
		paramMap.put("PASSWORD", encPassword);
		paramMap.put("PASSWORD_OG", PASSWORD);
//		member.setPASSWORD(encPassword);
		
		MultipartFile uploadfiles = uploadfile;
		
		if(!uploadfiles.isEmpty()) {
			String fileName = uploadfiles.getOriginalFilename();//원래 파일명
			String EMPNO = (String) paramMap.get("EMPNO");
			
			String saveFolder = new File("src/main/resources/static/profile").getAbsolutePath();
//			String saveFolder= profileSaveFolder.getProfilesavefolder();
			List<String> fileDBName = fileDBName(fileName, saveFolder, EMPNO);
			Logger.info("fileDBName : " + fileDBName);
			
			String fileDBNames = fileDBName.get(0);
			String refileName = fileDBName.get(1);
			
			//transferTo(file path) : 업로드된 파일을 매개변수의 경로에 저장합니다.
			uploadfile.transferTo(new File(saveFolder + fileDBNames));
			Logger.info("transferTo path : " + saveFolder + fileDBNames);
			//바뀐 파일명으로 저장
			paramMap.put("PROFILE_IMG", refileName);
//			member.setPROFILE_IMG(fileDBName);
			System.out.println("absolutePathss " +saveFolder);
			//파일 경로 이름
//			member.setPROFILE_FILE("profile" + fileDBName);
			paramMap.put("PROFILE_FILE", "profile" + fileDBNames);
		}
		
		Map <String, Object> resultMap = new HashMap<String, Object>();
		int registerCheck = memberservice.userNaverRegisterPro(paramMap);
		System.out.println(registerCheck);
		
		String EMAIL = (String) paramMap.get("EMAIL");
		String EMPNO = (String) paramMap.get("EMPNO");
		
		//삽입이 된 경우
		if(registerCheck == 1) {
			MailVO vo = new MailVO();
			vo.setTo(EMAIL);
			vo.setContent(EMPNO + "님 회원 가입을 축하드립니다.");
			sendMail.sendMail(vo);
				
			rattr.addFlashAttribute("result", "naverSuccess");
			return "redirect:sign_in";
			
		}else {
			model.addAttribute("url", request.getRequestURI());
			model.addAttribute("message","회원 가입 실패");
					
			return "error/error";
		}
		
//		if(registerCheck != 0 && registerCheck > 0) {
//			Map<String, Object> loginCheck = memberservice.userNaverLoginPro(paramMap);
//			session.setAttribute("userInfo", loginCheck);
//			rattr.addFlashAttribute("JavaData", "YES");
////			resultMap.put("JavaData", "YES");
//		}else {
//			rattr.addFlashAttribute("JavaData", "NO");
////			resultMap.put("JavaData", "NO");
//		}
		
//		return "redirect:sign_in";
//		return resultMap;
	}
	
	
	
	
	
	
	
	
	
	

	
	/* 구글아이디로 로그인 */	
	@ResponseBody
	@RequestMapping(value = "/loginGoogle", method = RequestMethod.POST)
	public String GoogleLoginPro(@RequestParam Map<String,Object> paramMap,HttpSession session) throws SQLException, Exception {
		System.out.println("paramMap:" + paramMap);
		
		Map<String, Object> GoogleConnectionCheck = memberservice.GoogleConnectionCheck(paramMap);
		System.out.println("GoogleConnectionCheck:" + GoogleConnectionCheck);
		if(GoogleConnectionCheck == null) { //일치하는 이메일 없으면 가입
			return "register";
			
		}else{
			return "YES";
		}
		
	}
	
	//값 받아서 회원가입으로
	@PostMapping("/setSnsInfo")
	public String setKakaoInfo(Model model,HttpSession session,@RequestParam Map<String,Object> paramMap) {
		System.out.println("setGoogleInfo");	
		System.out.println("param ==>"+paramMap);
		
		model.addAttribute("email",paramMap.get("email"));
		model.addAttribute("id",paramMap.get("id"));
		model.addAttribute("name",paramMap.get("name"));
		return "/Member/joinForm3";
	}
    
	//구글 회원가입 처리
	@RequestMapping(value="/userGoogleRegisterPro", method=RequestMethod.POST)
	public String userGoogleRegisterPro(@RequestParam Map<String,Object> paramMap,HttpSession session, RedirectAttributes rattr,
			@RequestParam String PASSWORD, @RequestParam MultipartFile uploadfile, Model model, HttpServletRequest request) throws SQLException, Exception {
		System.out.println("paramMap=" + paramMap);
			
		//비밀번호 암호화 추가
		String encPassword = passwordEncoder.encode(PASSWORD);
		Logger.info(encPassword);
		paramMap.put("PASSWORD", encPassword);
		paramMap.put("PASSWORD_OG", PASSWORD);
			
		MultipartFile uploadfiles = uploadfile;
			
		if(!uploadfiles.isEmpty()) {
			String fileName = uploadfiles.getOriginalFilename();//원래 파일명
			String EMPNO = (String) paramMap.get("EMPNO");
			
			String saveFolder = new File("src/main/resources/static/profile").getAbsolutePath();
			List<String> fileDBName = fileDBName(fileName, saveFolder, EMPNO);
			Logger.info("fileDBName : " + fileDBName);
			
			String fileDBNames = fileDBName.get(0);
			String refileName = fileDBName.get(1);
			
			uploadfile.transferTo(new File(saveFolder + fileDBNames));
			Logger.info("transferTo path : " + saveFolder + fileDBNames);
			//바뀐 파일명으로 저장
			paramMap.put("PROFILE_IMG", refileName);
			System.out.println("absolutePathss " +saveFolder);
			//파일 경로 이름
			paramMap.put("PROFILE_FILE", "profile" + fileDBNames);
		}
		
		int registerCheck = memberservice.userGoogleRegisterPro(paramMap);
		System.out.println(registerCheck);
			
		String EMAIL = (String) paramMap.get("EMAIL");
		String EMPNO = (String) paramMap.get("EMPNO");
		
		//삽입이 된 경우
		if(registerCheck == 1) {
			MailVO vo = new MailVO();
			vo.setTo(EMAIL);
			vo.setContent(EMPNO + "님 회원 가입을 축하드립니다.");
			sendMail.sendMail(vo);
				
			rattr.addFlashAttribute("result", "googleSuccess");
			return "redirect:sign_in";
			
		}else {
			model.addAttribute("url", request.getRequestURI());
			model.addAttribute("message","회원 가입 실패");
					
			return "error/error";
		}
			
	}
    
	//구글 로그인
	@PostMapping("/GoogleLogin")
	public String GoogleLogin(HttpSession session, @RequestParam Map<String, Object> paramMap, @RequestParam String id) {
		System.out.println("paramMap="+ paramMap);
		System.out.println("id="+ id);
		
		Map<String, Object> loginCheck = memberservice.userGoogleLoginPro(paramMap);
		System.out.println("userInfo="+ loginCheck);
		session.setAttribute("userInfo", loginCheck);
		
		String EMPNO = (String) loginCheck.get("EMPNO");
		String PASSWORD_OG = (String) loginCheck.get("PASSWORD_OG");
		session.setAttribute("EMPNO", EMPNO);
		session.setAttribute("PASSWORD_OG", PASSWORD_OG);
		
		return "redirect:sign_in";
	}
    
    
	
	
	
	
	
	
	
	
	
	
	
	//로그인
	@GetMapping(value = "/sign_in")
	public ModelAndView signIn(ModelAndView mv, 
			@CookieValue(value="remember-me", required=false) Cookie readCookie,
			HttpSession session, Principal userPrincipal, Model model, HttpServletRequest request) {
		
		
		if(readCookie != null) {
			Logger.info("저장된 아이디 : " + userPrincipal.getName());//Principal.getName() : 로그인한 아이디
			mv.setViewName("redirect:/index");
		}else {
			String naverAuthUrl = naverloginbo.getAuthorizationUrl(session);
			model.addAttribute("naverUrl", naverAuthUrl);
			Logger.info("naverAuthUrl="+naverAuthUrl);
			
			mv.setViewName("Member/sign_in");
			mv.addObject("loginfail", session.getAttribute("loginfail"));
			//세션에 저장된 값을 한 번만 실행될 수 있도록 mv에 저장하고
			session.removeAttribute("loginfail");//세션의 값은 제거합니다.
		}
		
		return mv;	
	}
	
	//아이디 찾기 페이지
	@RequestMapping("/id_check")
	public String idCheck() {
		return "/Member/id_check";
	}
	
	//이메일 인증
	@ResponseBody
	@RequestMapping(value = "/emailcerti", method = RequestMethod.POST)
	public String emailcerti(String email) {	
		System.out.println("전달받은 이메일:"+email);
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		/* 이메일 보내기 */
        String setFrom = "dmswjddid37@naver.com";
        String toMail = email;
        String title = "BOAT 인증 이메일 입니다.";
        String content = 
                "BOAT 홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + " 입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        return Integer.toString(checkNum);
 
	}
	
	//아이디 찾기 => 아이디 목록
	@GetMapping("/id_list")
	public String idList(RedirectAttributes rattr, @RequestParam String name, @RequestParam String email,
			Model mv) {
		List<Member> idlist = memberservice.getidlist(name, email);
		System.out.println("idlist="+idlist);
		String url = "";
		
		if(idlist.isEmpty()) {
			System.out.println("idlist == null");
			
			rattr.addFlashAttribute("message", "idnull");
			return "redirect:id_check";
			
		}else {
			System.out.println("idlist != null");
			
			mv.addAttribute("idlist", idlist);
			url="/Member/id_list";
			
			return url;
		}
		
	}
	
	//아이디 리스트 => 로그인
	@GetMapping("/id_login")
	public ModelAndView id_login(ModelAndView mv, @RequestParam String userid) {
		System.out.println("userid"+ userid);
		mv.addObject("userid", userid);
		mv.setViewName("/Member/sign_in");
		
		return mv;
	}
	
	
	
	
	
	
	
	
	
	//비번 찾기 페이지
	@RequestMapping("/pwd_check")
	public String pwdCheck() {
		return "/Member/pwd_check";
	}
	
	//비번설정 페이지
	@GetMapping("/pwd_check_ok")
	public String pwdCheckok(@RequestParam String name, @RequestParam String empno, @RequestParam String email, 
			Model mv, RedirectAttributes rattr) {
		System.out.println("name="+name);
		System.out.println("empno="+empno);
		System.out.println("email="+email);
		
		String url = "";
		
		Member member = memberservice.getPassword(name, empno, email);
		System.out.println("member="+member);
		
		if(member ==  null) {
			System.out.println("member == null");
			
			rattr.addFlashAttribute("message", "membernull");
			return "redirect:pwd_check";
			
		}else {
			System.out.println("member != null");
			
			mv.addAttribute("empno", member.getEMPNO());
			url="/Member/pwd_check_ok";
			
			return url;
		}
		
	}
	
	//비밀번호 수정
	@PostMapping("/pwdmodify")
	public String pwdmodify(@RequestParam String empno, @RequestParam String password, RedirectAttributes rattr,
			Model model, HttpServletRequest request) {
		System.out.println("empno="+empno);
		System.out.println("password="+password);
		
		//비밀번호 암호화 추가
		String encPassword = passwordEncoder.encode(password);
		Logger.info(encPassword);
		
		int pwdModify = memberservice.pwdupdate(empno, password, encPassword);
		System.out.println("pwdModify="+pwdModify);
		
		if(pwdModify == 0) {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "비밀번호 수정 실패");
			return "error/error";
			
		}else {
			rattr.addFlashAttribute("result", "passSuccess");
			return "redirect:sign_in";
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	//내 정보 수정
	@RequestMapping(value = "/updateProcess", method = RequestMethod.POST)
	public String member_updateProcess(RedirectAttributes rattr, Model model, HttpServletRequest request,
			Member member, HttpSession session) throws Exception {
		
		member.setPASSWORD_OG(member.getPASSWORD());
		
		//비밀번호 암호화 추가
		String encPassword = passwordEncoder.encode(member.getPASSWORD());
		Logger.info(encPassword);
		member.setPASSWORD(encPassword);
		
		//프로필
		MultipartFile uploadfile = member.getUploadfile();
		
		if(!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();//원래 파일명
			
			String saveFolder = new File("src/main/resources/static/profile").getAbsolutePath();
			List<String> fileDBName = fileDBName(fileName, saveFolder, member.getEMPNO());
			Logger.info("fileDBName : " + fileDBName);
			
			String fileDBNames = fileDBName.get(0);
			String refileName = fileDBName.get(1);
			
			//transferTo(file path) : 업로드된 파일을 매개변수의 경로에 저장합니다.
			uploadfile.transferTo(new File(saveFolder + fileDBNames));
			Logger.info("transferTo path : " + saveFolder + fileDBNames);
			//바뀐 파일명으로 저장
			member.setPROFILE_IMG(refileName);
			Logger.info("fileDBNames : " + fileDBNames);
			
			System.out.println("absolutePathss " +saveFolder);
			//파일 경로 이름
			member.setPROFILE_FILE("profile" + fileDBNames);
		}
		
		int result = memberservice.update(member);
		
		if(result==1) {
			
			session.setAttribute("PROFILE_FILE", member.getPROFILE_FILE());
			session.setAttribute("NAME", member.getNAME());
			session.setAttribute("DEPT", member.getDEPT());
			
			rattr.addFlashAttribute("message","updateSuccess");
			
			try {
		        Thread.sleep(3000);
		    } catch (InterruptedException e) {
		        e.printStackTrace();
		    }
			
			return "redirect:/index";
		}else {
			model.addAttribute("url", request.getRequestURL());
			model.addAttribute("message", "정보 수정 실패");
			return "error/error";
		}
	}
	
	//내 정보
	@GetMapping("/myinfo")
	public ModelAndView myinfo(Principal principal, ModelAndView mv) {

		String id = principal.getName();
		System.out.println("id="+id);
		
		if(id==null) {
			mv.setViewName("redirect:sign_in");
			Logger.info("id is null");
				
		}else {
			Member m = memberservice.member_info(id);
			mv.setViewName("/Member/myinfo");
			mv.addObject("memberinfo", m);
		}
			
		return mv;
	}
	
	//회원정보 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String member_delete(@RequestParam String empno, ModelAndView mv, HttpServletRequest request,
			RedirectAttributes rattr, HttpSession session) {
		System.out.println("empno="+empno);
		
		int result = memberservice.delete(empno);
		System.out.println("deleteresult="+result);
		
		if(result == 1) {
			rattr.addFlashAttribute("message","deleteSuccess");
			session.invalidate();
			SecurityContextHolder.clearContext();
			
			return "redirect:/index";
		}else {
			mv.addObject("url", request.getRequestURL());
			mv.addObject("message", "계정 삭제에 실패했습니다.");
			
			return "error/error";
		}
	}
	
	
	
	
	
	
	
	
	
	
	

	/**
	 * 방 페이지
	 * @return
	 */
	@RequestMapping("/chat")
	public String chatroom(Principal principal) {
		return "/Chat/chatroom";
	}
	
	/**
	 * 3. 유저 목록
	 * @param session
	 * @return
	 */
	@GetMapping(value = "/userLists")
	public ModelAndView userLists(HttpSession session) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("h:mm a | MMM d", new Locale("en", "US"));
		
		ModelAndView mav = null;
		
		ArrayList<Member> userList = memberservice.selectUserList();
		System.out.println("userList="+userList);
		
		mav = new ModelAndView("/Chat/users");
		
		mav.addObject("userList", userList);
		
		mav.addObject("date", sdf.format(new Date()));
		
		return mav;
	}
	
	/**
	 * 3. 메세지 HTML 전송
	 * JSON 타입의 파라미터를 받기 위해서는 @RequestBody 어노테이션을 붙여줘야 한다.
	 * 
	 * @param session
	 * @param map
	 * @return
	 */
	@PostMapping(value = "/message")
	@ResponseBody
	public ModelAndView message(HttpSession session, @RequestBody HashMap<String, String> map) { 
		System.out.println("message");
		System.out.println("map="+map);
		
		SimpleDateFormat sdf = new SimpleDateFormat("h:mm a | MMM d일", Locale.KOREAN);
		
		ModelAndView mav = null;
		
		Member m = memberservice.member_info(map.get("uuid"));
		
		mav = new ModelAndView("/Chat/message"); 
		
		Member user = (Member)session.getAttribute("loginUser");
		String sender = map.get("sender");
		System.out.println("sender="+map.get("sender"));
		
		mav.addObject("profile", m.getPROFILE_FILE());
		System.out.println("user.getNAME()="+user.getNAME());
		if(!user.getNAME().equals(sender)) {
			mav.addObject("sender", sender);
		}
		
		System.out.println("map.get="+map.get("content"));
		mav.addObject("content", map.get("content"));
		mav.addObject("date", sdf.format(new Date()));
		return mav;
	}
	
	@GetMapping(value = "/send")
	public ModelAndView send(@RequestParam HashMap<String, String> map, ModelAndView mav, Principal principal) {
		System.out.println("sendmap="+map);
		
		String id = principal.getName();
		Member m = memberservice.member_info(id);
		
		SimpleDateFormat sdf = new SimpleDateFormat("h:mm a | MMM d일", Locale.KOREAN);
		String formattedDate = new SimpleDateFormat("h:mm a | MMM d일", Locale.KOREAN).format(new Date());
		
		String content = map.get("content");
		String uuid = map.get("uuid");
		chatmessageservice.messageinsert(content, uuid, id, formattedDate);
		
		mav.setViewName("/Chat/send");
		
		mav.addObject("profile", m.getPROFILE_FILE());
		mav.addObject("content", map.get("content"));
		mav.addObject("date", sdf.format(new Date()));
		return mav;
	}
	
	@GetMapping(value = "/loadm")
	public ModelAndView loadm(@RequestParam String uuid, ModelAndView mav, Principal principal, ChatMessage chatMessage) {
		System.out.println("uuid="+uuid);
		String id = principal.getName();
		
		List<ChatMessage> chatHistory = chatmessageservice.getChatHistory(id, uuid);
		
		mav.setViewName("/Chat/loadm");
		
		Member m = memberservice.member_info(id);
		Member m2 = memberservice.member_info(uuid);
		
		mav.addObject("sendprofile", m.getPROFILE_FILE());
		mav.addObject("sendid", m.getEMPNO());
		
		mav.addObject("receiverprofile", m2.getPROFILE_FILE());
		mav.addObject("receiverid", m2.getEMPNO());
		mav.addObject("sender", m2.getNAME());
		mav.addObject("chatHistory", chatHistory);
		
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	//내 글 보기
	//자료실, 워크보드 추가
	@GetMapping("/myboardList")
	public ModelAndView myboardList(@RequestParam(value="page",defaultValue="1",required=false) int page, Principal principal, ModelAndView mv) {
		
		String id = principal.getName();
		System.out.println("id="+id);
		String empno = "";
		
		if(id==null) {
			mv.setViewName("redirect:sign_in");
			Logger.info("id is null");
				
		}else {
			Member m = memberservice.member_info(id);
			mv.addObject("memberinfo", m);
			
			empno = m.getEMPNO();
		}
		System.out.println("empno="+empno);
		
		int limit = 10; 
		int listcount = memberservice.getMyListCount(empno);
		System.out.println("listcount="+listcount);
		
		int maxpage = (listcount + limit - 1) / limit;
		
		int startpage = ((page-1) /10) *10 +1;
		int endpage = startpage +10 -1;
		
		if(endpage>maxpage)
			endpage=maxpage;
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar cal = Calendar.getInstance();
	    String today = format.format(cal.getTime());
	    System.out.println("today="+today);
	    cal.add(Calendar.DAY_OF_MONTH, -3); //3일간 보이도록 하기위해서.
	    String nowday = format.format(cal.getTime());
		
		
	  List<Board> boardlist = memberservice.getMyBoardList(page,limit,empno);
		
		mv.setViewName("/Member/myboardList");
		mv.addObject("page",page);
		mv.addObject("maxpage",maxpage);
		mv.addObject("startpage",startpage);
		mv.addObject("endpage",endpage);
		mv.addObject("listcount",listcount);
		mv.addObject("boardlist",boardlist);
		mv.addObject("limit",limit);
		mv.addObject("nowday",nowday);
		mv.addObject("today",today);
			
		return mv;
		
	}
	
	
}
