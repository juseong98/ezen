package cteam.dto;

import java.util.Random;

import cteam.dao.DBManager;
import cteam.dao.MailSender;
import cteam.vo.UserVO;

public class UserDTO extends DBManager
{
	public UserVO Read(String id) 
	{
		UserVO user = null;
		
		this.DBOpen();
		String sql = "";
		sql = "select id,pw,name,nick,team,position,email,joindate,userdiv ";
		sql += "from user ";
		sql += "where id='" + sRep(id) + "' ";
		this.RunSelect(sql);
		System.out.println(sql);
		if(this.Next() == true)
		{
			user = new UserVO();
			user.setId(this.getValue("id"));
			user.setName(this.getValue("name"));
			user.setPw(this.getValue("pw"));
			user.setNick(this.getValue("nick"));
			user.setTeam(this.getValue("team"));
			user.setPosition(this.getValue("position"));
			user.setEmail(this.getValue("email"));
			user.setJoindate(this.getValue("joindate"));
			user.setUserdiv(this.getValue("userdiv"));
		}
		this.DBClose();
		return user;
	}
	
	//�α��� 
	public boolean Login(String id, String pw)
	{
		boolean islogin = false;
		this.DBOpen();
		String sql = "";
		sql = "select id from user where id='" + sRep(id) + "' and pw = md5('" + sRep(pw) + "')";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			System.out.println("�α��� ����");
			islogin = true;
		}else 
		{
			System.out.println("�α��� ����");
		}
		this.DBClose();
		return islogin;
	}
	
	//���̵� �ߺ��˻�
	public boolean IsDuplicate(String id)
	{
		boolean flag = false;
		this.DBOpen();
		
		String sql = "";
		sql = "select id from user where id='" + sRep(id) + "' ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			flag = true;
		}
		this.DBClose();
		return flag;
	}
	
	//�г��� �ߺ��˻�
	public boolean IsCuplicate(String nick)
	{
		System.out.println("�޼ҵ� ��"+nick);
		boolean flag = false;
		this.DBOpen();
		
		String sql = "";
		sql = "select nick from user where nick='" + sRep(nick) + "' ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			flag = true;
		}
		this.DBClose();
		return flag;
	}
	
	//�г��� �ߺ� �˻� (���̵�� �г���)
	public boolean IsCuplicate(String nick, String id)
	{
		System.out.println("�޼ҵ� ��"+nick);
		boolean flag = false;
		this.DBOpen();
		
		String sql = "";
		sql = "select nick from user where id='" + sRep(id) + "' and nick='" + nick +"'";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			flag = true;
		}
		this.DBClose();
		return flag;
	}
	
	//���� ��й�ȣ �˻�
	public boolean IsPuplicate(String id, String pw)
	{
		boolean flag = false;
		this.DBOpen();
		
		String sql = "";
		sql = "select pw from user where id = '" + id + "' and pw=md5('" + pw + "')";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			flag = true;
		}
		this.DBClose();
		return flag;
	}
	
	//ȸ������
	public boolean Join(UserVO user)
	{
		if(this.IsDuplicate(user.getId()) == true)
		{
			System.out.println("�ߺ��� ���̵� [" + user.getId() + "] �Դϴ�." );
			return false;
		}
		if(this.IsCuplicate(user.getNick()) == true)
		{
			System.out.println("�ߺ��� �г��� [" + user.getNick() + "] �Դϴ�." );
			return false;
		}
		
		if(this.EmailCheck(user.getEmail()) == false)
		{
			System.out.println("���Ե� �̸��� �Դϴ�.");
			return false;
		}
		this.DBOpen();
		
		String sql = "";
		sql = "insert into user (id,pw,name,nick,team,position,email,userdiv) ";
		sql += "values ('" + sRep(user.getId()) + "',";
		sql += "md5('" + sRep(user.getPw()) + "'),";
		sql += "'"+ sRep(user.getName()) + "',";
		sql += "'"+ sRep(user.getNick()) + "',";
		sql += "'"+ (user.getTeam()) + "',";
		sql += "'"+ user.getPosition() + "',";
		sql += "'"+ sRep(user.getEmail()) + "',";
		sql += "'1') ";
		System.out.println(sql);
		this.RunSQL(sql);
		this.DBClose();
		
		return true;
	}
	
	//�̸��� �ߺ��˻�
	public boolean EmailCheck(String email)
	{
		this.DBOpen();
		String sql = "";
		sql = "select email from user where email='" + sRep(email) +"'";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			return false;
		}
		this.DBClose();
		return true;
	}
	
	
	//���� ���ڿ� ����
	public String GetToken()
	{
		int tokenlength = 5;
		String[] token = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B", "C", "d", "E", "F", "G", "H", "x", "J", "K", "b", "M", "N", "y", "P", "r", "R", "S", "T", "u", "V", "W", "X", "Y", "Z"};
		Random random = new Random(System.currentTimeMillis());
		int tablelength = token.length;
		StringBuffer buf = new StringBuffer();
		for(int i = 0; i < tokenlength; i++)
		{
		    buf.append(token[random.nextInt(tablelength)]);
		}	
		String code = buf.toString();
		return code;
	}
	
	//�̸��� ���� 
	public boolean sendEmail(String email, String code)
	{
		//String code = this.GetToken();
		
		MailSender mail = new MailSender();
		//boolean flag = 
				mail.MailSend("rkdckdgml119@naver.com", email , "rkdckdgml119", "ckdgml0926!", "�̸��������ڵ�", code);
		return true;
	}
	
	//ȸ�����Խ� �Է��� �̸��Ϸ� id�� pw ã��
	public boolean Ipuser(String id)
	{
		boolean isuser = false;
		this.DBOpen();
		String sql = "";
		sql = "select id from user where id='" + sRep(id) + "' ";
		this.RunSelect(sql);
		if(this.Next() == true)
		{
			//this.IpEmail(vo);
			System.out.println("���� �� ��ū ");
			isuser = true;
		}else 
		{
			System.out.println("���� ã�� ����");
		}
		this.DBClose();
		return isuser;
	}
	
	//������ �Է��� �̸����� ȸ������ �� �Է��� �̸��Ϸ� ����
	public boolean IpEmail(String email)
	{
		this.updatepw(email);
		UserVO vo = new UserVO();
		this.DBOpen();
		String sql ="";
		sql = "select id from user where email='" +email + "'";
		this.RunSelect(sql);
		this.Next();
		vo.setId(this.getValue("id"));
		this.DBClose();
		MailSender mail = new MailSender();
		mail.MailSend("rkdckdgml119@naver.com", email, "rkdckdgml119", "ckdgml0926!", "<LOLEZEN>  ����� ���̵�/��й�ȣ ���� �ȳ�","���̵�: " + vo.getId()  + "��й�ȣ : 123<br>�α��� �� ��й�ȣ�� �����ϼ���" );
		return true;
	}
	
	//��й�ȣ �ʱ�ȭ
	public void updatepw(String email)
	{
		this.DBOpen();
		String sql ="";
		sql = "update user set pw =md5('123') where email='" + email + "'";
		this.RunSQL(sql);
		this.DBClose();
		
	}
	
	//ȸ�� ���� ����
	public void Update(String id,String pw,String team,String position,String nick)
	{
		this.DBOpen();
		
		String sql = "";
		sql = "update user set ";
		sql += "pw = md5('" + sRep(pw) + "'),";
		sql += "team = '" + team + "', ";
		sql += "position = '" +  position + "', ";
		sql += "nick = '" + sRep(nick) + "' ";
		sql += "where id = '" + id +"' ";
		System.out.println(sql);
		this.RunSQL(sql);
		this.DBClose();
	}
	
}
