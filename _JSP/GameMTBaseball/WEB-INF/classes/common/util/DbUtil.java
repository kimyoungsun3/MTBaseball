package common.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DbUtil
{
	public static int getXXX(int _x){
		return _x;	
	}
	
  public static Connection getConnection() throws SQLException
  {
    Connection conn = null;
    try
    {
    	//System.out.println(111);
      InitialContext context = new InitialContext();
      //System.out.println(112);
      DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/mssql");
      //System.out.println(113);
      
      conn = ds.getConnection();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return conn;
  }
  
  public static void closeConnection(Connection con)
  {
    if (con != null) {
      try
      {
        con.close();
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
  }
  
  public static void closeConnection(Statement stmt)
  {
    if (stmt != null) {
      try
      {
        stmt.close();
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
  }
  
  public static void closeConnection(PreparedStatement pstmt)
  {
    if (pstmt != null) {
      try
      {
        pstmt.close();
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
  }
  
  public static void closeConnection(ResultSet rs)
  {
    if (rs != null) {
      try
      {
        rs.close();
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
  }
  
  public static void closeConnection(CallableStatement call)
  {
    if (call != null) {
      try
      {
        call.close();
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
  }
  
  public static void commitConnection(Connection con)
  {
    if (con != null) {
      try
      {
        con.commit();
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
  }
  
  public static void rollbackConnection(Connection con)
  {
    if (con != null) {
      try
      {
        con.rollback();
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
  }
  
  public static void setAutoCommit(Connection con, boolean onTran)
  {
    if (con != null) {
      try
      {
        con.setAutoCommit(onTran);
      }
      catch (Exception e)
      {
        e.printStackTrace();
      }
    }
  }
}
