using System.IO;
 
 class EnsureFile {
 static void Main(string[])
	{
Console.WriteLine(File.Exists("input.txt"));
Console.WriteLine(File.Exists("/input.txt"));
Console.WriteLine(Directory.Exists("docs"));
Console.WriteLine(Directory.Exists("/docs"));
}
}