package user;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // /UserSearchServlet여기로 넘어온 값들을 전부 utf-8로 처리하겠다 
		response.setContentType("text/html;charset=UTF-8");
		
		String userName = request.getParameter("userName");  //사용자가 검색창에서  검색한 값을 요청에 담긴 파라미터 값 "userName" 가져오기 
		response.getWriter().write(getJSON(userName)); //json형태로 출력해주기 
	}
	
	
	/**
	 * 서버에서 받아온 데이터들을 JSON 형태로 만들기  
	 * @param userName
	 * @return
	 */
	//클라이언트에서 요청을 보내면 뒷단에서 결과를 불러올때 JSON의 형태로 돌려줌 
	public String getJSON(String userName) {
		if(userName == null) userName = ""; 
		
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		UserDAO userDAO = new UserDAO();
		ArrayList<User> userList =  userDAO.search(userName); //userDAO에 있는 search 함수에서 모든 회원정보 가져오기 
		for(int i = 0; i < userList.size(); i++) {
			result.append("[{\"value\": \"" + userList.get(i).getUserName() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserAge() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserGender() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getUserEmail() + "\"}],");
		}
		result.append("]}");
		System.out.println(result);
		return result.toString(); //결과 반환 
		
	}
	

}
