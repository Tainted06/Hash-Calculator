Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
[xml]$xaml = @"
<Window
    ResizeMode="NoResize"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window"
    Title="Powershell Hash Calculator | https://github.com/Tainted06/Hash-Calculator"
    Height="285"
    Width="710">
    <Grid>
        <TextBox x:Name = "file" IsReadOnly="True" HorizontalAlignment="Left" Height="23" Margin="10,10,0,0" TextWrapping="Wrap" Text="File" VerticalAlignment="Top" Width="492"/>
        <TextBox IsReadOnly="True" HorizontalAlignment="Left" Height="196" Margin="10,38,0,0" TextWrapping="Wrap" Text="SHA1 Hash: &#xD;&#xA;&#xD;&#xA;SHA256 Hash: &#xD;&#xA;&#xD;&#xA;SHA384 Hash: &#xD;&#xA;&#xD;&#xA;SHA512 Hash: &#xD;&#xA;&#xD;&#xA;MD5 Hash: " VerticalAlignment="Top" Width="110" RenderTransformOrigin="-0.758,-3.652" FontSize="16" BorderThickness="0"/>
        <Button x:Name = "Button2" Content="Calculate Hash" HorizontalAlignment="Left" Margin="597,10,0,0" VerticalAlignment="Top" Width="85" Height="23"/>
        <Button x:Name = "Button1" Content="Select File" HorizontalAlignment="Left" Margin="507,10,0,0" VerticalAlignment="Top" Width="85" Height="23"/>
        <TextBox x:Name = "sha1" IsReadOnly="True" HorizontalAlignment="Left" Height="24" Margin="125,38,0,0" TextWrapping="Wrap" Text="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" VerticalAlignment="Top" Width="557" FontSize="15"/>
        <TextBox x:Name = "sha256" IsReadOnly="True" HorizontalAlignment="Left" Height="40" Margin="125,70,0,0" TextWrapping="Wrap" Text="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" VerticalAlignment="Top" Width="557" FontSize="15"/>
        <TextBox x:Name = "sha384" IsReadOnly="True" HorizontalAlignment="Left" Height="43" Margin="125,114,0,0" TextWrapping="Wrap" Text="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" VerticalAlignment="Top" Width="557" FontSize="15"/>
        <TextBox x:Name = "sha512" IsReadOnly="True" HorizontalAlignment="Left" Height="39" Margin="125,163,0,0" TextWrapping="Wrap" Text="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" VerticalAlignment="Top" Width="557" FontSize="11"/>
        <TextBox x:Name = "md5" IsReadOnly="True" HorizontalAlignment="Left" Height="24" Margin="125,210,0,0" TextWrapping="Wrap" Text="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" VerticalAlignment="Top" Width="557" FontSize="15"/>
    </Grid>
</Window>
"@
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$sha512 = New-Object -TypeName System.Security.Cryptography.SHA512CryptoServiceProvider
$sha384 = New-Object -TypeName System.Security.Cryptography.SHA384CryptoServiceProvider
$sha256 = New-Object -TypeName System.Security.Cryptography.SHA256CryptoServiceProvider
$sha1 = New-Object -TypeName System.Security.Cryptography.SHA1CryptoServiceProvider
$calculatehash = $Window.FindName("Button2")
$pickfile = $Window.FindName("Button1")
$md5hashtextbox = $Window.FindName("md5")
$sha512hashtextbox = $Window.FindName("sha512")
$sha256hashtextbox = $Window.FindName("sha256")
$sha384hashtextbox = $Window.FindName("sha384")
$sha1hashtextbox = $Window.FindName("sha1")
$FilePathTextBox = $Window.FindName("file")
$pickfile.Add_Click({
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        Multiselect = $false # Multiple files can be chosen

    }
    [void]$FileBrowser.ShowDialog()
    $FilePath = $FileBrowser.FileName;
    $FilePathTextBox.Clear()
    $FilePathTextBox.AppendText(($FilePath))
})
$calculatehash.Add_Click({
    if ($FilePathTextBox.Text -NE "File")
    {    
        $hashmd5 = [System.BitConverter]::ToString($md5.ComputeHash([System.IO.File]::ReadAllBytes($FilePathTextBox.Text)))
        $hashsha512 = [System.BitConverter]::ToString($sha512.ComputeHash([System.IO.File]::ReadAllBytes($FilePathTextBox.Text)))
        $hashsha384 = [System.BitConverter]::ToString($sha384.ComputeHash([System.IO.File]::ReadAllBytes($FilePathTextBox.Text)))
        $hashsha256 = [System.BitConverter]::ToString($sha256.ComputeHash([System.IO.File]::ReadAllBytes($FilePathTextBox.Text)))
        $hashsha1 = [System.BitConverter]::ToString($sha1.ComputeHash([System.IO.File]::ReadAllBytes($FilePathTextBox.Text)))
        $md5hashtextbox.Clear()
        $sha512hashtextbox.Clear()
        $sha384hashtextbox.Clear()
        $sha1hashtextbox.Clear()
        $sha256hashtextbox.Clear()
        $md5hashtextbox.AppendText(("{0}`r" -f $hashmd5))
        $sha512hashtextbox.AppendText(("{0}`r" -f $hashsha512))
        $sha1hashtextbox.AppendText(("{0}`r" -f $hashsha1))
        $sha256hashtextbox.AppendText(("{0}`r" -f $hashsha256))
        $sha384hashtextbox.AppendText(("{0}`r" -f $hashsha384))
    }
    else
    {
        [System.Windows.MessageBox]::Show('Please Pick a File First!')
    }
})
$window.ShowDialog()
