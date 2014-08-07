import java.util.ArrayList;


public class EditDistance {
	
	public static ArrayList<String> case1(String word)
	{
		/**
		 * Changing any one character
		 */
		ArrayList<String> AL = new ArrayList<String>();
		int len = word.length();
		char[] charArray = word.toCharArray();
		for(int i=0;i<len;i++)
		{
			for(char c='a';c<'z';c++)
			{
				if(word.charAt(i)!=c)
				{
					charArray[i] = c;
					AL.add(new String(charArray));
				}
			}
			charArray = word.toCharArray();
		}
		return AL;
	}
	
	
	public static ArrayList<String> case2(String word)
	{
		/**
		 * Removing one charater from the string
		 */
		ArrayList<String> AL = new ArrayList<String>();
		int len = word.length();
		for(int i=0;i<len;i++)
		{
			String s = word.substring(0, i)+word.substring(i+1);
			AL.add(s);
		}
		return AL;
			
	}
	
	
	public static ArrayList<String> case3(String word)
	{

		ArrayList<String> AL = new ArrayList<String>();
		int len = word.length();
		for(int i=0;i<len;i++)
		{
			for(char c='a';c<'z';c++)
			{
				String s = word.substring(0,i) + append(c,word.substring(i));
				AL.add(s);
			}
			
		}
		return AL;
	}
	
	public static ArrayList<String> case4(String word)
	{
		/**
		 * Adding letter after the word
		 */
		ArrayList<String> AL = new ArrayList<String>();
		for(char c='a';c<'z';c++)
		{
			String s= word + c;
			AL.add(s);
		}
		return AL;
	}
	
	public static String append(char a,String b)
	{
		return new String(a+b);
	}
	
	public static ArrayList<String> OneEditDistance(String word)
	{
		ArrayList<String> AL = case1(word);
		ArrayList<String> AL1= case2(word);
		ArrayList<String> AL2= case3(word);
		ArrayList<String> AL3= case4(word);
		ArrayList<String> array = new ArrayList<String>();
		array.addAll(AL);
		array.addAll(AL1);
		array.addAll(AL2);
		array.addAll(AL3);
		return array;
		
	}
	
	public static void main(String args[])
	{
		for(String s: OneEditDistance("abc"))
		{
			System.out.println(s);
		}
		
	}

}
