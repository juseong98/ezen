package cteam.vo;

public class UserVO
{
	protected String id;       //���̵�
	protected String pw;       //��й�ȣ
	protected String name;     //�̸�
	protected String nick;     //�г���
	protected String team;     //��
	protected String position; //������
	protected String email;    //�̸���
	protected String joindate; //��������
	protected String userdiv;  //��������
	
	
	public String getId()		{		return id;			}
	public String getPw()		{		return pw;			}
	public String getName()		{		return name;		}
	public String getNick()		{		return nick;		}
	public String getTeam()		{		return team;		}
	public String getPosition()	{		return position;	}
	public String getEmail()	{		return email;		}
	public String getJoindate()	{		return joindate;	}
	public String getUserdiv()	{		return userdiv;		}
	
	public void setId(String id)				{	this.id = id;				}
	public void setPw(String pw)				{	this.pw = pw;				}
	public void setName(String name)			{	this.name = name;			}
	public void setNick(String nick)			{	this.nick = nick;			}
	public void setTeam(String team)			{	this.team = team;			}
	public void setPosition(String position)	{	this.position = position;	}
	public void setEmail(String email)			{	this.email = email;			}
	public void setJoindate(String joindate)	{	this.joindate = joindate;	}
	public void setUserdiv(String userdiv)		{	this.userdiv = userdiv;		}
	
	
	

}
