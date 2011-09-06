# Log�s�v�ӏ�Cut�֐�
# param $file Cut�O��log�t�@�C����
# param $formatFile Cut���log�t�@�C����
# [�{PowerShell���g�p���邽�߂̑O�����]
# 1. PowerShell���C���X�g�[������Ă��邱�ƁB
# 2. PowerShell�̊O�����s��������Ă��邱��(�����łȂ��ꍇ�A�ȉ��̃R�}���h��PowerShell������s����K�v����B)
#    set-executionpolicy remotesigned(Windows7�̏ꍇ�A�E�N���b�N�Ǘ��Ҍ����Ŏ��s���K�v)
#
function LogCut($file,$formatFile)
{
	#Write-Host $file
	#Write-Host $formatFile
    # �t�H�[�}�b�g�Ocsv�t�@�C���̒��g���擾
	$lines = Get-Content $file
	# �t�H�[�}�b�g�Ocsv�t�@�C���̍s�����擾
	$linescount = $(Get-Content $file | Measure-Object).Count
	#Write-Host $linescount
	
	# �t�@�C���̒��g�����݂���ꍇ�̂ݏ������s��
    for ($i = 0; $i -lt $linescount; $i++)
    {
    	#Write-Host $i
        #Write-Host $lines[$i]
        if ($lines[$i] -ne $null -and $lines[$i].Length -gt 31) {
    		$line = $lines[$i].Remove(0,31)
            # �t�H�[�}�b�g�����s��csv�t�@�C���ɏo��
    		Add-Content $formatFile -Value $line
        }
    }
}

# �֐����s
LogCut $args[0] $args[1]