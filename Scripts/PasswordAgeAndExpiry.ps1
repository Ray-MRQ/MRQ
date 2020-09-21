Get-ADUser -filter * -properties passwordlastset, passwordneverexpires, Enabled, samAccountName | sort-object name | select-object Name, samAccountName, passwordlastset, passwordneverexpires, Enabled | Export-csv -path C:\Users\$env:USERNAME\Desktop\PassAgeExpiry.csv