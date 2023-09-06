//�Խù��� �Ű������� ��(Model)�Ѻ��� ó���ϱ� ����
//DTO Ŭ����(Data Transfer Object)
package cteam.dto;

import cteam.vo.*;
import java.util.ArrayList;
import cteam.dao.*;

public class ServiceDTO extends DBManager
{
	public void InsertB(ServiceVO vo)
	{
		//C :ServiceVO��ü�� DB�� ����(insert)�Ѵ�.
		this.DBOpen();
		String sql = "";
		sql  = "insert into service (id, sdiv,bno) ";
		sql += "values ('" + vo.getId() + "'," ;
		sql += "'" + vo.getSdiv() + "'," ;
		sql += "'" + vo.getBno() + "' )";
		System.out.println(sql);
		this.RunSQL(sql);
		
		sql = "select last_insert_id() as no ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setRno(this.getValue("no"));
		}
		
		this.DBClose();
	}
	
	public void InsertR(ServiceVO vo)
	{
		//C :ServiceVO��ü�� DB�� ����(insert)�Ѵ�.
		this.DBOpen();
		String sql = "";
		sql  = "insert into service (id, rno) ";
		sql += "values ('" + vo.getId() + "'," ;
		sql += "'" + vo.getRno() + "')" ;		
		System.out.println(sql);
		this.RunSQL(sql);
		
		sql = "select last_insert_id() as no ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			vo.setRno(this.getValue("no"));
		}
		
		this.DBClose();
	}
	
	//R : DB���� �ڷḦ �����ͼ� (select) ServiceVO�� �ִ´�.
	public void Read(String bno)
	{
		ServiceVO vo = null;
		this.DBOpen();
		
		String sql = "";
		sql  = "select ";
		sql += "bno,id,rno,sdiv ";
		sql += "from service ";
		System.out.println(sql);
		this.RunSelect(sql);
		vo.setBno(this.getValue("bno"));
		vo.setId(this.getValue("id"));
		vo.setRno(this.getValue("rno"));
		vo.setSdiv(this.getValue("sdiv"));
		this.DBClose();
	}
	
	//scan = true : ��õ�Ű� ���� , false : ���� x
	public boolean Bcheck(String bno, String sdiv, String id)
	{
		boolean scan = false;
		this.DBOpen();
		String sql = "";
		sql ="select * from service where bno = '" + bno + "' and sdiv = '" + sdiv + "' and id = '" + id + "' ";
		this.RunSelect(sql);
		if(this.Next() == false)
		{
			scan = true;
		}
		this.DBClose();
		
		return scan;
	}
	
	public boolean Rcheck(String rno, String id)
	{
		boolean scan = false;
		this.DBOpen();
		String sql = "";
		sql ="select * from service where rno= '" + rno + "' and id = '"+id+"' ";
		this.RunSelect(sql);
		if(this.Next() == false)
		{
			scan = true;
		}
		this.DBClose();
		
		return scan;
	}
	
}
