package cteam.vo;

public class ChatVO
{
	protected String cno;   //ä�ù�ȣ
	protected String id;    //���̵�
	protected String cnote; //ä�ó���
	protected String nick;  //ä�ó���
	
	public String getCno()		{	return cno;		}
	public String getId()		{	return id;		}
	public String getCnote()	{	return cnote;	}
	public String getNick()		{ 	return nick;	}
	
	
	public void setCno(String cno)		{	this.cno = cno;		}
	public void setId(String id)		{	this.id = id;		}
	public void setCnote(String cnote)	{	this.cnote = cnote;	}
	public void setNick(String nick)	{	this.nick = nick;	}

	
}
