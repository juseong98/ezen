//����¡ ó�� Ŭ����
package cteam.vo;

public class PageVO 
{
	protected int    pageTotal;   //��ü ������ ����
	protected int    blockStart;  //������ ���� �� 
	protected int    blockEnd;    //������ ���� ��
	protected String pgURL;       //����¡ URL ���ø�
	
	//��ü ������ ���� ����
	public void SetPgTotal(int dataTotal,int pageNow)
	{
		//��ü �Խù� ������ ������ ���Ѵ�.
		pageTotal = (dataTotal/10);
		//�����Ͱ� 10�� ����� ���
		if(dataTotal % 10 != 0) pageTotal++;
		//������ �� ���
		SetPgBlock(pageNow);
	}
	
	//����¡ ��� ���
	public void SetPgBlock(int pageNow)
	{
		//������ ���� �� ���
		blockStart = pageNow - (pageNow % 5) + 1;
		if(pageNow % 5 == 0)
		{
			blockStart = (pageNow - 1) - ((pageNow - 1) % 5) + 1;
		}		
		//������ ���� �� ���
		blockEnd = blockStart + 5;
		
		//������ ���� �� ���� ��ü ������ �������� ũ��...
		if(blockEnd >= pageTotal) blockEnd = pageTotal + 1;		
	}
	
	//����¡ ���ø��� �����Ѵ�.
	public void SetPgURL(String url)
	{
		pgURL = url;
	}
	
	//���� �� ���
	public String GetPrevBlock()
	{
		String url = pgURL;

		if(blockStart > 1)
		{
			url = url.replace("{page}", Integer.toString(blockStart - 1));
		}else
		{
			url = "";
		}
		System.out.println("GetPrevBlock : " + url);
		return url;
	}
	
	//���� �� ���
	public String GetNextBlock()
	{
		String url = pgURL;

		if(blockEnd < pageTotal)
		{
			url = url.replace("{page}", Integer.toString(blockEnd));
		}else
		{
			url = "";
		}
		System.out.println("GetNextBlock : " + url);
		return url;
	}	
	
	//����¡ ���
	public String GetPaging(int pageNow)
	{
		String url = "";
		for(int i = blockStart; i < blockEnd; i++)
		{
			url += pgURL.replace("{page}", Integer.toString(i));
			url += "\n";
		}	
		System.out.println("GetPaging : " + url);
		return url;
	}
	
	public String PrintPaging(String pgURL)
	{
		String url = pgURL;
		//���� ��
		String urlPrev    = "";
		String urlPgBlock = "";
		String urlNext    = "";
		
		return "";
	}
}
