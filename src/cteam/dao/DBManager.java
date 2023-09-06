package cteam.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBManager
{
	private Connection conn;
	private Statement  stmt;
	private ResultSet  rs;
	
	public DBManager()
	{
		conn = null;
		stmt = null;
	}
	
	//����̹� �ε� �� DB ���� 
	public boolean DBOpen()
	{
		//1. jdbc ���̺귯�� �ε�
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e)
		{
			e.printStackTrace();
			return false;
		}
		//2. �����ͺ��̽��� ����
		String host = "jdbc:mysql://192.168.0.39:3306/cteam";
		host += "?useUnicode=true&characterEncoding=utf-8";
		host += "&serverTimezone=UTC";
		
		try
		{
			conn = DriverManager.getConnection(host,"root","ezen");
			stmt = conn.createStatement();
		} catch (SQLException e)
		{
			e.printStackTrace();
			return false;
		}
		System.out.println("�����ͺ��̽� ���� ����");
		return true;
	}

//	//����̹� �ε� �� DB ���� 
//	public boolean DBOpen(String dbName, String id, String pw)
//	{	
//		//1. jdbc ���̺귯�� �ε�
//		try
//		{
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			//2. �����ͺ��̽��� ����
//			String host = "jdbc:mysql://127.0.0.1:3306/" + dbName;
//			host += "?useUnicode=true&characterEncoding=utf-8";
//			host += "&serverTimezone=UTC";
//			conn = DriverManager.getConnection(host,id,pw);
//			stmt = conn.createStatement();
//		} catch (ClassNotFoundException e)
//		{
//			e.printStackTrace();
//			return false;
//		} catch (SQLException e1)
//		{
//			e1.printStackTrace();
//			return false;
//		}
//		
//		System.out.println("�����ͺ��̽� ���� ����");
//		return true;
//	}
	
	//DB ���� �ݱ�
	public void DBClose()
	{
		try
		{
			stmt.close();
			conn.close();
		} catch (SQLException e)
		{
			e.printStackTrace();
		}
	}
	
	//Insert, Delete, Update ����
	public boolean RunSQL(String sql)
	{
		try
		{
			stmt.executeUpdate(sql);
		} catch (SQLException e)
		{
			e.printStackTrace();
			return false;
		}
		sql = sql.replace("\t", "");
		System.out.println(sql);
		return true;
	}
	
	//Select ����
	public boolean RunSelect(String sql)
	{
		try
		{
			rs = stmt.executeQuery(sql);
		} catch (SQLException e)
		{
			e.printStackTrace();
			return false;
		}
		sql = sql.replace("\t", "");
		System.out.println(sql);
		return true;
	}
	
	//ResultSet�� Next ó�� -> ResultSet rs�� private��
	public boolean Next()
	{
		try
		{
			return rs.next();
		} catch (SQLException e)
		{
			e.printStackTrace();
			return false;
		}
	}
	
	//ResultSet�� getString ó��
	public String getValue(String column)
	{
		try
		{
			return rs.getString(column);
		} catch (SQLException e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	//���� ����ǥ ����
	public String sRep(String data)
	{
		if(data == null) return null;
		return data.replace("'", "''");
	}
}
