package cteam.vo;

public class ReplyVO
{
	protected String rno;      //��۹�ȣ
	protected String bno;      //�Խñ۹�ȣ
	protected String id;       //���̵�
	protected String rnote;    //��۳���
	protected String rblcount; //��۽Ű���
	protected String nick;     //�ۼ��� �г���
	protected String team;     //�ۼ��� ��
	protected String position; //�ۼ��� ������
	
	
	
	
	
	
	public String getNick()		{	return nick;		}
	public String getRno()		{	return rno;			}
	public String getBno()		{	return bno;			}
	public String getId()		{	return id;			}
	public String getRnote()	{	return rnote;		}
	public String getRblcount()	{	return rblcount;	}
	public String getTeam()		{	return team;		}
	public String getPosition() {	return position;	}
	
	public void setRno(String rno)				{	this.rno = rno;				}
	public void setBno(String bno)				{	this.bno = bno;				}
	public void setId(String id)				{	this.id = id;				}
	public void setRnote(String rnote)			{	this.rnote = rnote;			}
	public void setRblcount(String rblcount)	{	this.rblcount = rblcount;	}
	public void setNick(String nick)			{	this.nick = nick;			}
	public void setTeam(String team) 			{	this.team = team;			}
	public void setPosition(String position) 	{	this.position = position;	}
	

}
