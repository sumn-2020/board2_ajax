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
			 String dbURL = "jdbc:mysql://localhost:3306/Ajax"; //mysql에 Ajax라는 테이블에 접속
			 String dbID = "root";
			 String dbPassword = "java";
			 Class.forName("com.mysql.jdbc.Driver"); //db에 접근할 수 있는 라이브러리 
			 conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); //오류가 뭔지 출력하기 
		}
	}
	
	

	
	
	
}
