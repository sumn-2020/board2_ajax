package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // /UserSearchServlet여기로 넘어온 값들을 전부 utf-8로 처리하겠다 
		response.setContentType("text/html;charset=UTF-8");
		
		String userName = request.getParameter("userName");  //사용자가 검색창에서  검색한 값을 요청에 담긴 파라미터 값 "userName, userAge, userGender,userEmail " 가져오기 
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		response.getWriter().write(registerFn(userName, userAge, userGender, userEmail)+""); //json형태로 출력해주기 
		//  + "" => 숫자가 문자열 형태로 출력될수있도록 만들기 
	}
	
	
	
	public int registerFn(String userName, String userAge, String userGender, String userEmail) {
		User user = new User();
		try {
			user.setUserName(userName);
			user.setUserAge(Integer.parseInt(userAge));
			user.setUserGender(userGender);
			user.setUserEmail(userEmail);
		} catch (Exception e) {
			return 0; //실패시 0 출력 
		}

		return new UserDAO().register(user);  //성공시 UserDAO속에 있는 resiger 메소드 실행 되면서 1 반환
		
	}
	

}
