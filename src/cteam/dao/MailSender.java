package cteam.dao;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailSender 
{
	public boolean MailSend(String from,String to,String id,String pw,String title,String body)
	{
		try
		{  
			System.out.println("send stage 01");
			
			Properties clsProp = System.getProperties();
			
			// ���� ���� �ּ�
			clsProp.put( "mail.smtp.host", "smtp.naver.com" );
			
			// ���� ���� ��Ʈ ��ȣ
			clsProp.put( "mail.smtp.port", 465 );			
			
			System.out.println("send stage 02");
			
			// ������ �ʿ��ϸ� �Ʒ��� ���� �����Ѵ�.
			clsProp.put("mail.smtp.auth", "true"); 
			clsProp.put("mail.smtp.ssl.enable", "true"); 
			clsProp.put("mail.smtp.ssl.trust", "smtp.naver.com");			
			
			System.out.println("send stage 03");
			
			Session clsSession = Session.getInstance( clsProp, new Authenticator(){
					public PasswordAuthentication getPasswordAuthentication()
					{
						// ���� ���̵�/��й�ȣ�� �����Ѵ�.
						return new PasswordAuthentication( id, pw );
					}
				} );
			
			System.out.println("send stage 04");
			
			Message clsMessage = new MimeMessage( clsSession );
			
			// �߽��� �̸��� �ּҸ� �����Ѵ�.
			clsMessage.setFrom( new InternetAddress( from ) );
			
			System.out.println("send stage 05");
			
			// ������ �̸��� �ּҸ� �����Ѵ�.
			clsMessage.addRecipient( Message.RecipientType.TO, new InternetAddress( to ) );
			
			System.out.println("send stage 06");
			
			// ������ �����Ѵ�.
			clsMessage.setSubject( title );
			
			// ���� ������ �����Ѵ�. �ҽ� �ڵ带 euc-kr �� �ۼ��Ͽ��� charset �� euckr �� ������.
			clsMessage.setContent( body , "text/html;charset=euckr" );
			
			System.out.println("send stage 07");
			
			// ���� ����
			Transport.send( clsMessage );
			
			
			System.out.println("send stage 08");
		}
		catch( Exception e )
		{
			e.printStackTrace();
			return false;
		}		
		return true;
	}
	
	public static void main(String[] args) 
	{
		
		MailSender m = new MailSender();
		m.MailSend("rkdckdgml119@naver.com", 
				"rkdckdgml119@naver.com",
				"rkdckdgml119","ckdgml0926!",
				"this is title","this is body");
		
		
		//MailSender Ŭ������ �Ʒ��� ���� ������ �����Ͽ� ���� ����!!!!!!!!!!
		
		/*
		MailSender send = new MailSender();
		send.setFrom("rkdckdgml119@naver.com","rkf");
		send.setTo("test@gmail.com");
		send.setTitle("�̰��� �����Դϴ�.");
		send.setBody("<a href='autho.jsp?id=121212'>�����ϱ�</a>");
		send.sendMail();	
		*/
	}

}

