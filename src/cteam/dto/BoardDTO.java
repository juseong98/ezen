package cteam.dto;

import cteam.vo.*;

import java.util.ArrayList;
//import cteam.dao.*;
import cteam.dao.DBManager;

public class BoardDTO extends DBManager
{
	//C:BoardVO��ü�� DB�� ����(insert)�Ѵ�.
	public void Insert(BoardVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql  = "insert ";
		sql += "	into board (id,btitle,bnote,menu,bfname,bpname,youtube,newslink) values (";
		sql += "	'" + vo.getId()       + "', ";
		sql += "	'" + sRep(vo.getBtitle())   + "', "; 
		sql += "	'" + sRep(vo.getBnote())    + "', ";
		sql += "	'" + vo.getMenu()     + "', "; 
		sql += "	'" + sRep(vo.getBfname())   + "', "; 
		sql += "	'" + vo.getBpname()   + "', ";
		sql += "	'" + sRep(vo.getYoutube())  + "', ";
		sql += "	'" + sRep(vo.getNewslink()) + "') ";
		this.RunSQL(sql);
		
		//��ϵ� �Խù��� ��ȣ�� ��´�
		sql = "select last_insert_id() as no ";
		this.RunSelect(sql);
		if( this.Next() == true )
		{
			vo.setBno(this.getValue("no"));
		}
		this.DBClose();
	}
	
	//R:DB���� �ڷḦ �����ͼ�(select) BoardVO�� �ִ´�.
	//IsHit: true - ��ȸ�� ����, false - ��ȸ�� �������� ����
	public BoardVO Read(String bno, boolean IsHit)
	{
		BoardVO vo = null;
		this.DBOpen();
		String sql = "";
		sql  = "select ";
		sql += "	id,btitle,menu,bnote,bfname,bpname,wdate,hit,gcount,blcount,youtube,newslink, ";
		sql += "	(select nick from user where id = board.id) as nick, ";
		sql += "	(select nick from user where id = board.id) as nick, ";
		sql += "	(select team from user where id = board.id) as team,";
		sql += "	(select position from user where id = board.id) as position ";
		sql += "from ";
		sql += "	board ";
		sql += "where ";
		sql += "	bno = '" + bno + "' ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			//�Խù� ������ ����
			vo = new BoardVO();
			vo.setBno(bno);
			vo.setId(this.getValue("id"));
			vo.setBtitle(this.getValue("btitle"));
			vo.setMenu(this.getValue("menu"));
			vo.setBnote(this.getValue("bnote"));
			vo.setBfname(this.getValue("bfname"));
			vo.setBpname(this.getValue("bpname"));
			vo.setWdate(this.getValue("wdate"));
			vo.setHit(this.getValue("hit"));
			vo.setNick(this.getValue("nick"));
			vo.setTeam(this.getValue("team"));
			vo.setPosition(this.getValue("position"));
			vo.setGcount(this.getValue("gcount"));
			vo.setBlcount(this.getValue("blcount"));
			vo.setYoutube(this.getValue("youtube"));
			vo.setNewslink(this.getValue("newslink"));
			//��ȸ�� ���� ��Ų��
			if(IsHit == true)
			{
				sql = "update board set hit = hit + 1 where bno = '" + bno + "' ";
				this.RunSQL(sql);
			}

		}
		this.DBClose();
		return vo;
	}
	
	//��õ ���
	public void GoodUpdate(BoardVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql = "update board set gcount = gcount + 1 where bno = " + vo.getBno();
		this.RunSQL(sql);
		this.DBClose();
	}
	
	//�Ű���
	public void BlockUpdate(BoardVO vo)
	{
		this.DBOpen();
		String sql = "";
		sql = "update board set blcount = blcount + 1 where bno = " + vo.getBno();
		this.RunSQL(sql);
		this.DBClose();
	}
	
	//U:BoardVO��ü�� DB�� ����(update)�Ѵ�.
	public void Update(BoardVO vo)
	{
		this.DBOpen();

		String sql = "";
		
		sql  = "update ";
		sql += "	board ";
		sql += "set ";
		sql += "	btitle = '"   + sRep(vo.getBtitle())   + "', ";
		sql += "	menu = '"     + vo.getMenu()     + "', ";
		sql += "	youtube = '"  + vo.getYoutube()  + "', ";
		sql += "	newslink = '" + vo.getNewslink() + "', ";
		if(!vo.getBfname().equals(""))
		{
			//���� �����Ǳ� �� ÷�������� ���� ��, �� ÷�������� �״�� ������Ʈ 
			sql += "bnote = '"  + sRep(vo.getBnote())  + "', ";
			sql += "bfname = '" + sRep(vo.getBfname()) + "', ";
			sql += "bpname = '" + vo.getBpname() + "'  ";
		}else
		{
			sql += "bnote = '" + sRep(vo.getBnote()) + "' ";
		}
		sql += "where ";
		sql += "	bno = '" + vo.getBno() + "' ";
		this.RunSQL(sql);
		this.DBClose();
	}
	
	//D:BoardVO��ü�� �̿��Ͽ� DB���� �����Ѵ�.
	public void Delete(String bno)
	{
		this.DBOpen();
		String sql = "";
		sql = "delete from service where bno = '" + bno + "' ";
		this.RunSQL(sql);
		sql = "delete from reply where bno = '" + bno + "' ";
		this.RunSQL(sql);
		
		sql = "delete from board where bno = '" + bno + "' ";
		this.RunSQL(sql);
		this.DBClose();
	}
	
	//R:��ü �Խù� ������ ��´�.
	//menu : ���� : N / ��ȸ : T / ���̶���Ʈ : H / ���� : F / ���� : Q / ���� : I / ��Ƽ : P / �̵� : M
	public int GetTotal(String menu)
	{
		int total = 0;
		
		this.DBOpen();
		String sql = "";
		sql  = "select count(*) as total "; 
		sql += "from board ";
		sql += "where menu = '" + menu + "' ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			total = Integer.parseInt(this.getValue("total"));
		}
		this.DBClose();
		return total;
	}
	
	public int GetTotal(String menu,String opt, String word)
	{
		int total = 0;
		
		this.DBOpen();
		String sql = "";
		sql  = "select count(*) as total "; 
		sql += "from board ";
		sql += "where menu = '" + menu + "' and " + opt + " like '%" + word + "%' ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			total = Integer.parseInt(this.getValue("total"));
		}
		this.DBClose();
		return total;
	}
	
	public ArrayList<BoardVO> List(String menu)
	{
		
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		
		this.DBOpen();
		String sql = "";
		sql  = "select ";
		sql += "	bno,btitle,menu,hit,youtube,gcount,blcount,youtube,bfname,bpname, ";
		sql += "	date_format(wdate, '%m-%d') as wdate,";
		sql += "	(select nick from user where id = board.id) as nick,";
		sql += "	(select team from user where id = board.id) as team,";
		sql += "	(select position from user where id = board.id) as position,";
		sql += "	(select count(*) from reply where bno = board.bno) as rcount ";
		sql += "from ";
		sql += "	board ";
		sql += "where ";
		sql += "	menu = '" + menu + "' and id in (select id from user where userdiv='2') ";
		sql += "order by bno desc ";
		sql += "limit 0,3";
		this.RunSelect(sql);
		while(this.Next() == true)
		{
			BoardVO vo = new BoardVO();
			vo.setBno(this.getValue("bno"));
			vo.setBtitle(this.getValue("btitle"));
			vo.setMenu(this.getValue("menu"));
			vo.setWdate(this.getValue("wdate"));
			vo.setHit(this.getValue("hit"));
			vo.setNick(this.getValue("nick"));
			vo.setRcount(this.getValue("rcount"));
			vo.setTeam(this.getValue("team"));
			vo.setPosition(this.getValue("position"));
			vo.setBfname(this.getValue("bfname"));
			vo.setBpname(this.getValue("bpname"));
			vo.setGcount(this.getValue("gcount"));
			vo.setBlcount(this.getValue("blcount"));
			vo.setYoutube(this.getValue("youtube"));
			
			list.add(vo);
		}
		this.DBClose();
		return list;
	}
	
	//R:DB���� �ڷ� ����� �����ͼ�(select) BoardVO LIST�� �ִ´�.
	//menu : ���� : N / ��ȸ : T / ���̶���Ʈ : H / ���� : F / ���� : Q / ���� : I / ��Ƽ : P / �̵� : M
	public ArrayList<BoardVO> List(String menu, int PageNo)
	{
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		
		int startNo = (PageNo - 1) * 10; //���۹�ȣ
		
		this.DBOpen();
		String sql = "";
		sql  = "select ";
		sql += "	bno,btitle,menu,hit,youtube,gcount,blcount,youtube,bfname,bpname, ";
		sql += "	date_format(wdate, '%m-%d') as wdate,";
		sql += "	(select nick from user where id = board.id) as nick,";
		sql += "	(select team from user where id = board.id) as team,";
		sql += "	(select position from user where id = board.id) as position,";
		sql += "	(select count(*) from reply where bno = board.bno) as rcount ";
		sql += "from ";
		sql += "	board ";
		sql += "where ";
		sql += "	menu = '" + menu + "'  and id in (select id from user where userdiv='1')  ";
		sql += "order by bno desc ";
		sql += "limit " + startNo + ",10";
		this.RunSelect(sql);
		System.out.println(sql);
		while(this.Next() == true)
		{
			BoardVO vo = new BoardVO();
			vo.setBno(this.getValue("bno"));
			vo.setBtitle(this.getValue("btitle"));
			vo.setMenu(this.getValue("menu"));
			vo.setWdate(this.getValue("wdate"));
			vo.setHit(this.getValue("hit"));
			vo.setNick(this.getValue("nick"));
			vo.setRcount(this.getValue("rcount"));
			vo.setTeam(this.getValue("team"));
			vo.setPosition(this.getValue("position"));
			vo.setBfname(this.getValue("bfname"));
			vo.setBpname(this.getValue("bpname"));
			vo.setGcount(this.getValue("gcount"));
			vo.setBlcount(this.getValue("blcount"));
			vo.setYoutube(this.getValue("youtube"));
			
			list.add(vo);
		}
		this.DBClose();
		return list;
	}
	
	//�˻� ����Ʈ �ҷ�����
	public ArrayList<BoardVO> ListSearch(String menu, int PageNo, String scOpt, String scWord)
	{
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		
		int startNo = (PageNo - 1) * 10; //���۹�ȣ
		
		this.DBOpen();
		String sql = "";
		sql  = "select bno,btitle,menu,hit,youtube,gcount,blcount,youtube,bfname,bpname, ";
		sql += "date_format(wdate, '%m-%d') as wdate, ";
		sql += "(select nick from user where id = board.id) as nick, ";
		sql += "(select team from user where id = board.id) as team, ";
		sql += "(select position from user where id = board.id) as position, ";
		sql += "(select count(*) from reply where bno = board.bno) as rcount ";
		sql += "from board ";
		sql += "where menu = '" + menu + "' and " + scOpt + " like '%" + scWord + "%' ";
		sql += "order by bno desc ";
		sql += "limit " + startNo + ",10";
		this.RunSelect(sql);
		
		while(this.Next() == true)
		{
			BoardVO vo = new BoardVO();
			vo.setBno(this.getValue("bno"));
			vo.setBtitle(this.getValue("btitle"));
			vo.setMenu(this.getValue("menu"));
			vo.setWdate(this.getValue("wdate"));
			vo.setHit(this.getValue("hit"));
			vo.setNick(this.getValue("nick"));
			vo.setRcount(this.getValue("rcount"));
			vo.setTeam(this.getValue("team"));
			vo.setPosition(this.getValue("position"));
			vo.setBfname(this.getValue("bfname"));
			vo.setBpname(this.getValue("bpname"));
			vo.setGcount(this.getValue("gcount"));
			vo.setBlcount(this.getValue("blcount"));
			vo.setYoutube(this.getValue("youtube"));
			
			list.add(vo);
		}
		this.DBClose();
		return list;
	}
	//�ֽű� �ҷ�����
	//1 : ��ȸ �з�, 2 : Ŀ�´�Ƽ �з�
	public ArrayList<BoardVO> ListRecent(String div)
	{
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		
		this.DBOpen();
		String sql = "";
		sql  = "select ";
		sql += "	bno,btitle,menu, ";
		sql += "	(select count(*) from reply where bno = board.bno) as rcount ";
		sql += "from ";
		sql += "	board ";
		if(div.equals("1")) sql += "where menu = 'N' or menu = 'T' or menu='H' ";
		if(div.equals("2")) sql += "where menu = 'F' or menu = 'Q' or menu='I' or menu='P' or menu='M' ";
		sql += "order by bno desc ";
		sql += "limit 0,10";
		this.RunSelect(sql);
		
		while(this.Next() == true)
		{
			BoardVO vo = new BoardVO();
			vo.setBno(this.getValue("bno"));
			vo.setBtitle(this.getValue("btitle"));
			vo.setMenu(this.getValue("menu"));
			vo.setRcount(this.getValue("rcount"));
			
			list.add(vo);
		}
		this.DBClose();
		return list;
	}	
	
	//�α�� �ҷ�����
	public ArrayList<BoardVO> ListPopular()
	{
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		
		this.DBOpen();
		String sql = "";
		sql  = "select ";
		sql += "	bno,btitle,menu ";
		sql += "from ";
		sql += "	board ";
		sql += "where ";
		sql += "	blcount < 10 ";
		sql += "order by gcount desc ";
		sql += "limit 0,10";
		this.RunSelect(sql);
		
		while(this.Next() == true)
		{
			BoardVO vo = new BoardVO();
			vo.setBno(this.getValue("bno"));
			vo.setBtitle(this.getValue("btitle"));
			vo.setMenu(this.getValue("menu"));
			
			list.add(vo);
		}
		this.DBClose();
		return list;
	}	
}
