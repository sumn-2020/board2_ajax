package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UserDAO {

	/**
	 * mysql에 접속하기 (DAO : 데이터 접근객체)
	 * 
	 */
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	public UserDAO() {
		try {
			 String dbURL = "jdbc:mysql://localhost:3306/AJAX"; //mysql에 ajax라는 테이블에 접속
			 String dbID = "root";
			 String dbPassword = "java";
			 Class.forName("com.mysql.jdbc.Driver"); //db에 접근할 수 있는 라이브러리 
			 conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); //오류가 뭔지 출력하기 
		}
	}
	
	
	
	
	/**
	 * 검색하기 기능 메소드 
	 * 모든회원 정보를 arraylist로 가져오기 
	 * 
	 */
	public ArrayList<User> search(String userName) {
		
		String SQL = "SELECT * FROM USER WHERE userName LIKE ? "; //매개변수로 넘어온 값(userName)을 포함한다면 .. 
		
		ArrayList<User> userList = new ArrayList<User>();
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, "%" + userName + "%"); //sql문 물음표안에 매개변수로 넘어온 userName을 넣어준다(와이드카드% 추가)
			rs = pstmt.executeQuery(); // sql문 실행 
			
			while (rs.next()) {
				User user = new User(); //User안에 정보 넣기 
				user.setUserName(rs.getString(1));
				user.setUserAge(rs.getInt(2));
				user.setUserGender(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				userList.add(user);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//System.out.println(userList);
		return userList;
		
	}
	
	
	
	
	
}
