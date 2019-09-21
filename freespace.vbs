Option Explicit

Dim objFSO 'File System Object
Dim objDrive 'Drive Object
Dim lngSpace 
Dim WshShell 'Shell Commander
Dim drive
Dim Threshold
Dim oArgs, ArgNum

'Scripted by Deon van Zyl

'Read Commandline

Set oArgs = WScript.Arguments
ArgNum = 0
drive = UCase(oArgs(ArgNum))

'Set Objects

Set objFSO = WScript.CreateObject("Scripting.FileSystemObject")
Set WshShell = CreateObject("WScript.Shell")

   select case drive 'Set for Drive cannot be done through a Var
      case "C" 
          Set objDrive = objFSO.Drives.Item("C")
	  Threshold = 2000000000   '2 GIG
      case "E"
          Set objDrive = objFSO.Drives.Item("E")
	  Threshold = 20000000000   '20 GIG
      case "G"
          Set objDrive = objFSO.Drives.Item("G")
	  Threshold = 20000000000   '20 GIG
      case Else:
          Set objDrive = objFSO.Drives.Item("C")
	  Threshold = 2000000000   '2 GIG
  end select


If objDrive.IsReady = True Then
     lngSpace = objDrive.FreeSpace

	 'msgbox lngSpace 

	If lngSpace < Threshold Then
     
	'Convert from Bytes to MB
    	 lngSpace = FormatNumber((lngSpace / 1024) / 1024 ,2)

	'-----------Create msg.txt (body of email-----)

	Dim objFileSystem, objOutputFile
	Dim strOutputFile

	' generate a filename base on the script name
	strOutputFile = "msg.txt"

	Set objFileSystem = CreateObject("Scripting.fileSystemObject")
	Set objOutputFile = objFileSystem.CreateTextFile(strOutputFile, TRUE)

	objOutputFile.WriteLine("Freespace = " & lngSpace & " Gig on " & drive & ": at " & Now )
	objOutputFile.WriteLine("Please inform the Websystems Team of this email on ext. 1633 ASAP.")
	objOutputFile.Close

	Set objFileSystem = Nothing

		'-----------------------------

	WshShell.Run "mailsend.bat"  'Drive is Low on Disk Space !! Will send a email notification

	'msgbox "freespace =" & lngSpace 
	
	End if	
	

End If

'Clear Environment
On Error Resume Next

Set objFSO = Nothing
Set objDrive = Nothing 

