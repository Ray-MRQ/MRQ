if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
Write-Output  "
____  __    _____    __   ____  _    _    __    ____  ____    ____  ____  __  __  _____  _  _  __    __   
(  _ \(  )  (  _  )  /__\ (_  _)( \/\/ )  /__\  (  _ \( ___)  (  _ \( ___)(  \/  )(  _  )( \/ )/__\  (  )  
 ) _ ( )(__  )(_)(  /(__)\  )(   )    (  /(__)\  )   / )__)    )   / )__)  )    (  )(_)(  \  //(__)\  )(__ 
(____/(____)(_____)(__)(__)(__) (__/\__)(__)(__)(_)\_)(____)  (_)\_)(____)(_/\/\_)(_____)  \/(__)(__)(____)"
Write-Output ''
Write-Output "HP Bloatware Removal Version 2.0"
Write-Output ''

$UWPAppList = "AD2F1837.HPPrinterControl",
    "AD2F1837.HPPCHardwareDiagnosticsWindows",
    "AD2F1837.HPSureShieldAI",
    "AD2F1837.HPPrivacySettings",
    "AD2F1837.HPJumpStarts",
    "AD2F1837.HPPowerManager",
    "AD2F1837.HPSystemEventUtility",
    "AD2F1837.HPInc.EnergyStar",
    "5A894077.McAfeeSecurity",
    "0E3921EB.sMedioTrueDVDforHP",
    "AD2F1837.HPWorkWell",
    "AD2F1837.HPQuickDrop",
    "AD2F1837.HPQuickDrop",
    "AD2F1837.HPSupportAssistant",
    "ExpressVPN",
    "McAfee Live"

$GAPApplist = "Assistant",
    "HP Documentation",
    "Documentation",
    "Guide",
    "Energy Star",
    "StatusAlerts",
    "Support",
    "HP Print SW",
    "HP Notifications",
    "Pixel Sharp",
    "Discover HP Touchpoint Manager",
    "HP 3D DriveGuard",
    "HP Welcome",
    "HP Registration Service",
    "HP Software Setup",
    "HP Sure Run",
    "HP Sure Recover",
    "HP Client Security Manager",
    "HP Sure Click Application Support for Windows",
    "HP Sure Click",
    "HP JumpStart Launch",
    "HP JumpStart Bridge",
    "HP Customer Experience Enhancements",
    "HP ESU for Microsoft Windows 10",
    "HP Support Solutions Framework",
    "HP Sure Sense Installer",
    "HP Connection Optimizer",
    "HP Performance Advisor"

$GUIDApplist = "{6F340107-F9AA-47C6-B54C-C3A19F11553F}",
      "{36D6FFE0-888D-4680-AA7B-B1F896CAB9F6}",
      "{E5B9C3E5-889C-4F22-A959-F4B8465D8876}",
      "{A30F03AC-EF79-40E4-AA5F-414EB135AFCF}",
      "{06FCC605-92A1-4A1C-B7D1-85E5778290A4}",
      "{669D4A35-146B-4314-89F1-1AC3D7B88367}",
      "{E84148C6-6E8D-40C5-832D-68EB369ACDE1}",
      "{B2EE25B9-5B00-4ACF-94F0-92433C28C39E}",
      "{3023EBDA-BF1B-4831-B347-E5018555F26E}",
      "{EBF9A3F5-C495-4A8D-91BF-7C23C67F72D0}",
      "{2F518061-89DB-4AF0-9A7A-2BF73B60E6F0}",
      "{912D30CF-F39E-4B31-AD9A-123C6B794EE2}",
      "{F9569D00-4576-46C8-B6C7-207A4FD39745}",
      "{E8D0E2B8-B64B-44BC-8E01-00DDACBDF78A}",
      "{E5823036-6F09-4D0A-B05C-E2BAA129288A}",
      "{0C57987A-A03A-4B95-A309-D23F78F406CA}",
      "{55CA337D-2BE3-4AA4-BA1E-652F4C02E893}",
      "{675D093B-815D-47FD-AB2C-192EC751E8E2}",
      "{5B08AF35-B699-4A44-BB89-3E51E70611E8}",
      "{C05002F1-06F8-4A15-B6F8-E4DC655C28AA}",
      "{6BA7C52E-4071-47CC-9060-ABB143862DB0}",
      "{ADE2F6A7-E7BD-4955-BD66-30903B223DDF}",
      "{07E79F52-1D78-4081-814E-BF093FF7A1BF}",
      "{F792E5B0-11C4-4C68-8A63-FB5F52749180}",
      "{130E5108-547F-4482-91EE-F45C784E08C7}",
      "{D79A02E9-6713-4335-9668-AAC7474C0C0E}",
      "{54CE68A8-4F2D-4328-B1F7-D6C720405F7F}",
      "{299625B9-6C69-462C-9CEA-8E06D878B1C5}",
      "{85A42FF0-F0D0-44A3-B226-C124D6E8B1D5}",
      "{FF21C3E6-97FD-474F-9518-8DCBE94C2854}",
      "{BC741628-0AFC-405C-8946-DD46D1005A0A}",
      "{254C37AA-6B72-4300-84F6-98A82419187E}",
      "{CBB639E0-B534-4827-97B5-CA1A4CA985B5}",
      "{0A47BAFF-D4FF-4BD3-96CA-02A22EA62722}",
      "{403996EB-2DCE-4C43-A2B8-2B956880772D}",
      "{40FB8D7C-6FF8-4AF2-BC8B-0B1DB32AF04B}",
      "{565E7B0E-B76B-4EAD-9753-F1E72A5CF12E}",
      "{CB7D766C-879F-4800-BB09-3D29E306EF63}",
      "{CC4D56B7-6F18-470B-8734-ABCD75BCF4F1}",
      "{1341D838-719C-4A05-B50F-49420CA1B4BB}",
      "{FA0FF682-CC70-4C57-93CD-E276F3E7537E}",
      "{2EEA7AA4-C203-4b90-A34F-19FB7EF1C81C}",
      "{62230596-37E5-4618-A329-0D21F529A86F}",
      "{687FEF8A-8597-40b4-832C-297EA3F35817}",
      "{20D48DD8-06BA-4d5a-9796-6C7582F07947}",
      "{38DAE5F5-EC70-4aa5-801B-D11CA0A33B41}",
      "{508CE680-CAF5-4d0a-86E5-84E7B0701F26}",
      "{268C2D6E-CDE9-47CD-87D9-A87710966709}",
      "{671B4BAD-D681-4d29-9498-D8BF3F1A389D}",
      "{6CC080F1-2E00-41D5-BE47-A3BC784E9DFB}",
      "{AFB69549-3AAE-4433-A99B-673B8A513379}",
      "{4F923F90-46D1-4492-9CC6-13FBBA00E7EC}",
      "{C918E3D8-208F-43DB-B346-6299D59336D7}",
      "{A5E65B95-F016-474D-BC0D-6AF64412BBDF}",
      "{39930586-2677-432B-B928-F970FB43F46F}",
      "{3B46DFDA-6155-423B-BCBB-F1C267E4ADD9}",
      "{3AF15EEA-8EDF-4393-BB6C-CF8A9986486A}",
      "{CA19DC3C-DA9E-40B1-B501-710F437604C0}",
      "{D5510D28-D0E4-433E-A0F3-EE3FCECA60D2}",
      "{167AA1D5-8412-44BC-A003-B7A3662D1CE2}",
      "{82E616DB-8BE9-46B7-AE42-60200985AD78}",
      "{28074A47-851D-4599-A270-87609F58EB57}",
      "{B411AD10-1BC9-4939-8848-BC5E66F662B7}",
      "{F1DD6CD2-6734-4089-9EF5-441F51E083B6}",
      "{F243A34B-AB7F-4065-B770-B85B767C247C}",
      "{04C23662-CE15-48BE-AF77-7BD9028934E7}",
      "{7940DAB9-AC72-4422-8908-DCF58C2C1D21}",
      "{226837D8-0BF8-4CBE-BAB2-8F07E2C2B4DD}",
      "{40FB8D7C-6FF8-4AF2-BC8B-0B1DB32AF04B}",
      "{EB58480C-0721-483C-B354-9D35A147999F}",
      "{7B7FF4D0-D4E2-4E8E-908D-90AB01BC4568}",
      "{6468C4A5-E47E-405F-B675-A70A70983EA6}",
      "{85DF2EED-08BC-46FB-90DA-28B0D0A8E8A8}",
      "{DFD6EBE3-F0DA-4E24-9202-37AF8D20888B}",
      "{ADDF4B84-5D28-4EAE-8511-EF808C8BC81C}",
      "{1504CF6F-8139-497F-86FC-46174B67CF7F}",
      "{59F8C5AA-91BD-423D-BF05-09A80F39898F}",
      "{11AF9A96-6D83-4C3B-8DCB-16EA2A358E3F}",
      "{3C92B2E6-380D-4fef-B4DF-4A3B4B669771}",
      "{55D003F4-9599-44BF-BA9E-95D060730DD3}",
      "{5B025634-7D5B-4B8D-BE2A-7943C1CF2D5D}",
      "{CE938F96-2EDD-4377-942A-1B877616E523}",
      "{A0B9F8DF-C949-45ed-9808-7DC5C0C19C81}",
      "{03A7C57A-B2C8-409b-92E5-524A0DFD0DD3}",
      "{0EF5BEA9-B9D3-46d7-8958-FB69A0BAEACC}",
      "{07FA4960-B038-49EB-891B-9F95930AA544}",
      "{C9EF1AAF-B542-41C8-A537-1142DA5D4AEC}",
      "{07F6DC37-0857-4B68-A675-4E35989E85E3}",
      "{07FA4960-B038-49EB-891B-9F95930AA544}",
      "{73A43E42-3658-4DD9-8551-FACDA3632538}",
      "{AB5E289E-76BF-4251-9F3F-9B763F681AE0}",
      "{9DBA770F-BF73-4D39-B1DF-6035D95268FC}",
      "{BF1E75D0-E7AF-4BEA-9FBC-567F0C54BDF9}",
      "{C27C82E4-9C53-4D76-9ED3-A01A3D5EE679}",
      "{C9EF1AAF-B542-41C8-A537-1142DA5D4AEC}",
      "{57A5AEC1-97FC-474D-92C4-908FCC2253D4}",
      "{7206B668-FEE0-455B-BB1F-9B5A2E0EC94A}",
      "{8126E380-F9C6-4317-9CEE-9BBDDAB676E5}",
      "{7EF7CCB0-52BF-4947-BE6E-E47D586E8842}",
      "{216C7F38-4BBC-4E9A-8392-C9FA21B54386}",
      "{F7632A9B-661E-4FD9-B1A4-3B86BC99847F}",
      "{97C1C98D-6AE5-4C71-9B00-EBBD9E014450}",
      "{5E487136-B52E-4856-8F5F-FCDF5E5FC5EE}",
      "{D99A8E3A-AE5A-4692-8B19-6F16D454E240}",
      "{EF9E56EE-0243-4BAD-88F4-5E7508AA7D96}",
      "{D7BC5D88-FC93-46D6-B7B0-145C2E168A95}",
      "{2642BE09-1F9F-4E18-AAD4-0258B9BCE611}",
      "{9EC0BE64-2C6C-428A-A4C2-E7EDF831B29A}",
      "{DBCD5E64-7379-4648-9444-8A6558DCB614}",
      "{BD7204BA-DD64-499E-9B55-6A282CDF4FA4}",
      "{55B52830-024A-443E-AF61-61E1E71AFA1B}",
      "{AB5D51AE-EBC3-438D-872C-705C7C2084B0}",
      "{F769B78E-FF0E-4db5-95E2-9F4C8D6352FE}",
      "{74C4DA32-D4FD-406B-AEA3-6781757C8EC3}",
      "{37EC8980-A8E5-411D-8CDD-CB1CCA95057F}",
      "{796E076A-82F7-4D49-98C8-DEC0C3BC733A}",
      "{33023FE8-9028-416A-8A5C-C115B59DD538}",
      "{0DE76F90-E993-47C7-BF6A-2B385492D490}",
      "{2021896F-CECA-463C-A7A8-9949A13910F7}",
      "{7BB949B9-EB47-47E4-814D-88F8CD301543}",
      "{D21BDA13-5E4C-401D-8353-2543251B40E2}",
      "{A4D282D0-1B48-481B-9E52-5F0B001A2BAB}",
      "{34412EC4-6A3C-454F-AF8B-75B0A0DF00AB}",
      "{861C4DFA-E691-4BA6-BE6B-D5BA211990B6}",
      "{3B1040BE-8AB0-4D80-A68E-029D70A0868B}",
      "{70E2B27F-0B7F-41B2-8145-E7377BC9F75A}",
      "{8C2259F3-35F4-4663-87BF-9F5F6AE6C4F7}",
      "{12F5A080-A6EE-4FCC-B355-80CBBF33FAA0}",
      "{89E40591-0404-4769-88E7-F649C95AE151}",
      "{65B2569D-303B-41EC-B38C-0934963BC3AD}",
      "{D9D8900B-CFEB-44C6-B417-D6308B5B145D}",
      "{29E6A126-BB06-41CF-B12D-E6A56261328D}",
      "{73A33079-D1A0-4469-8903-C4A48B4975E2}",
      "{C8D60CF4-BE7A-487E-BD36-535111BDB0FE}",
      "{06600E94-1C34-40E2-AB09-D30AECF78172}",
      "{025D3904-FA39-4AA2-A05B-9EFAAF36B1F2}",
      "{1F0493F6-311D-44E5-A9E6-F0D4C63FB8FD}",
      "{5340A3C6-4169-484A-ADA7-63BCF5C557A0}",
      "{7573D7E5-02BB-4903-80EB-36073A99BC8D}",
      "{791A06E2-340F-43B0-8FAB-62D151339362}",
      "{8327F6D2-C8CC-49B5-B8D1-46C83909650E}",
      "{84F0C8C0-263A-4B3A-888D-2A5FDEA15401}",
      "{8ABB6A99-E2D5-47E4-905A-2FD4657D235E}",
      "{9867A917-5D17-40DE-83BA-BEA5293194B1}",
      "{A6365256-0FBA-4DCD-88CE-D92A4DC9328E}",
      "{A1CFA587-90D4-4DE6-B200-68CC0F92252F}",
      "{53AE55F3-8E99-4776-A347-06222894ECD3}",
      "{95CC589C-8D98-4539-9878-4E6A342304F2}",
      "{9D20F550-4222-49A7-A7A7-7CAAB2E16C9C}",
      "{89A12FD9-8FA0-4EB9-AE9A-34C7EB25C25B}",
      "{25F3EC6C-BB03-4CEB-B36C-E656A9DD149E}",
      "{676981B7-A2D9-49D0-9F4C-03018F131DA9}",
      "{C29C1940-CB85-4F3B-906C-33FEE0E67103}",
      "{679EC478-3FF9-4987-B2FF-C2C2B27532A2}",
      "{9B362566-EC1B-4700-BB9C-EC661BDE2175}",
      "{B6465A32-8BE9-4B38-ADC5-4B4BDDC10B0D}",
      "{846B5DED-DC8C-4E1A-B5B4-9F5B39A0CACE}",
      "{74FE39A0-FB76-47CD-84BA-91E2BBB17EF2}",
      "{AF9E97C1-7431-426D-A8D5-ABE40995C0B1}",
      "{B05372A4-5AF0-4343-BA7B-2745E30A2D23}",
      "{34E6F14D-68F9-486D-87BA-6AA8431F3F44}",
      "{40F7AED3-0C7D-4582-99F6-484A515C73F2}",
      "{FC0ADA4D-8FA5-4452-8AFF-F0A0BAC97EF7}",
      "{0FA995CC-C849-4755-B14B-5404CC75DC24}",
      "{95BECC50-22B4-4FCA-8A2E-BF77713E6D3A}",
      "{240B2BF7-E7E6-425C-A2A4-A3149189BF7F}",
      "{A5F1C701-E150-4A86-A7F8-9E9225C2AE52}",
      "{6349342F-9CEF-4A70-995A-2CF3704C2603}",
      "{22706ADC-74A1-43A0-ABAE-47F84966B909}",
      "{2BF5E9CC-C55D-4B0F-ACAF-FFE77F333CD8}",
      "{A351CC1B-C92C-4F37-8109-9F6D33ACF5EF}",
      "{722A2876-B382-4AB5-8CC9-007FF5B28641}",
      "{66E6CE0C-5A1E-430C-B40A-0C90FF1804A8}",
      "{8894A6A7-547D-4326-B4BC-FB62B9075CE2}",
      "{53D3E126-699A-4D92-AA66-6560D573553E}",
      "{60F90886-FAEE-4768-9817-093AB0F30540}",
      "{415FA9AD-DA10-4ABE-97B6-5051D4795C90}",
      "{BB3447F6-9553-4AA9-960E-0DB5310C5779}",
      "{DBE16A07-DDFF-4453-807A-212EF93916E0}",
      "{9CAB2212-0732-4827-8EC4-61D8EF0AA65B}",
      "{5A847522-375C-4D05-BD3D-88C450CC047F}",
      "{11C9A461-DD9D-4C71-85A4-6DCE7F99CC44}",
      "{B6B9006D-5A0A-4F17-B69A-42F48C1FC30C}",
      "{445CC807-9384-47FA-A2B6-FFE970352B88}",
      "{F90A86C9-7779-47DD-AC06-8EE832C55F55}",
      "{1575F408-60AC-4a37-904A-931117272926}",
      "{4B322C8E-8775-4f20-8978-ED63DB4770C4}",
      "{7E60EE8D-0914-444E-A682-7703BDDEB5EB}",
      "{DE13432E-F0C1-4842-A5BA-CC997DA72A70}",
      "{A4966638-798C-45B9-B5BF-07D3E63B58C2}",
      "{7F94FB03-6617-4442-9817-CDDB36EAE529}",
      "{86BC184E-CFCD-48D5-829A-666A36C6ACC9}",
      "{B8454F30-79EC-4959-BCF1-3776DEC406AB}",
      "{BCFAA37D-A6DB-43BF-A351-43F183E52D07}",
      "{5C76ED0D-0F6F-4985-8B34-F9AE7834848F}",
      "{74038F40-03AE-4785-865B-07EC7F6A5E97}",
      "{04D66C1E-E5E2-483C-8715-916C42703924}",
      "{5D3E11CE-2C9A-44E3-A561-ED9BAC439E83}",
      "{83A375B6-6FC2-4F8A-948E-E506DB9DCDF0}",
      "{D2A2E5CD-801A-4B8D-8119-F79449A09B67}",
      "{F6D61EC9-347B-4019-9F8E-E24169F7C330}",
      "{2A186F69-BCC4-4529-9F24-A8FFB7F4E1C9}",
      "{6357258D-2BF9-49E7-A9EF-0C609D52C46D}",
      "{563ADFC1-38E6-4EF0-8763-7CDA8289944B}",
      "{C1223A79-3983-4877-B162-75031E7CE322}",
      "{DDEBEA89-2B5A-4E5B-8702-369882BB3F52}",
      "{BD019D8F-25B9-49D6-B301-07AFF65E35DD}",
      "{4989DD05-86FB-4CA2-96C5-923DFAD89DA3}",
      "{55D8D1AB-94C2-498F-A165-608B834A30EA}",
      "{274E6D9A-7CCD-4D67-9660-639486F466B2}",
      "{92AB9371-D327-4D56-9BDD-B38A671A631D}",
      "{32A4CF00-9FAC-47c8-9B37-91CC23815D64}",
      "{6357D25F-A9C9-4CC7-A1FB-0DCF344E7C40}",
      "{1F670068-9589-4DC7-8FE4-1D0D13AF2526}",
      "{E1AE0CB7-1333-4728-8520-CB3F88A252B4}",
      "{4E484899-4F93-4086-88BA-56BDDF47A776}",
      "{582BA1F1-FAB4-41AD-A5E3-4A9535343461}",
      "{BB3447F6-9553-4AA9-960E-0DB5310C5779}",
      "{FE651900-D014-482F-AEBC-2928F57D1FB0}",
      "{55979C41-7D6A-49CC-B591-64AC1BBE2C8B}",
      "{95D08F4E-DFC2-4ce3-ACB7-8C8E206217E9}",
      "{D360FA88-17C8-4F14-B67F-13AAF9607B12}",
      "{E553760D-D7F7-48BF-BD8B-C7E23BA04CB5}",
      "{4B4E2FA2-3B1E-4147-99DB-5033981D8C2F}",
      "{91A34181-9FAD-43AB-A35F-E7A8945B7E1C}",
      "{5A5F45AE-0250-4C34-9D89-F10BDDEE665F}",
      "{A3B64280-DE4C-40F0-86BB-CCB2A6056BA2}",
      "{88E60521-1E4E-4785-B9F1-1798A4BD0C30}",
      "{9DEF9686-CCB2-47B7-BF83-B49EA21FA016}",
      "{731A1D36-BF17-4C76-B7E7-CC055AF8C54E}",
      "{DCCAD079-F92C-44DA-B258-624FC6517A5A}",
      "{34FF930E-DBF9-4858-BAB5-BAC957BF616E}",
      "{2D5E3D2B-919F-407C-8757-E64827518BB6}",
      "{BB1C717E-376C-4AA1-8940-81BFC38D9778}",
      "{BB760C1D-98F4-4E38-8CC4-3B67329AA981}",
      "{9B9B8EE4-2EDB-41C2-AF2E-63E75D37CDDF}",
      "{7910018D-02CF-4410-A7E5-CF5C10D05B7F}",
      "{8A27C0FE-87C7-4169-BF5A-05BF94F70A54}",
      "{21706D5B-A09C-42F1-95B5-CBDFE20F9852}",
      "{446CCB22-B632-4A1D-BF84-DA8DB0575F98}",
      "{C927FC7E-4061-44AC-BE09-496AF6BAC131}",
      "{4B3264AA-951A-4A6B-B837-125224261F12}",
      "{791D3241-C6A4-417F-82E6-00543B6E5012}",
      "{D69F9215-B06A-4ADF-A464-E2607B2FA296}",
      "{10F539B1-31AF-43BF-9F0C-0EB66E918922}",
      "{394FA67A-FF0A-4356-BB77-D85E5A300BDE}",
      "{E2831862-F131-4327-B9CC-FA30F587EB6C}",
      "{9207D4A1-586E-49CA-A002-FC9F475AB1A3}",
      "{B899AE89-9B09-4F11-B299-A1209CAB8D00}",
      "{9ADABDDE-9644-461B-9E73-83FA3EFCAB50}",
      "{D734D743-2385-46ED-9B3E-168A24A9E1A9}",
      "{EC8D12E4-A73C-4C27-B1C7-E9683052E556}",
      "{708ABF62-5D7A-4550-823A-1F9EFA63645A}",
      "{7059BDA7-E1DB-442C-B7A1-6144596720A4}",
      "{274A948D-DD41-4B8F-B66F-0F4AD233200F}",
      "{CAE4213F-F797-439D-BD9E-79B71D115BE3}",
      "{681B698F-C997-42C3-B184-B489C6CA24C9}",
      "{20EFC9AA-BBC1-4DFD-81FF-99654F71CBF8}",
      "{B28635AB-1DF3-4F07-BFEA-975D911B549B}",
      "{D9D8F2CF-FE2D-4644-9762-01F916FE90A9}",
      "{EB21A812-671B-4D08-B974-2A347F0D8F70}",
      "{D79113E7-274C-470B-BD46-01B10219DF6A}",
      "{BAC712C6-4061-4C9F-AB58-A5C53E76704A}",
      "{150B6201-E9E6-4DFB-960E-CCBD53FBDDED}",
      "{67D3F1A0-A1F2-49b7-B9EE-011277B170CD}",
      "{36FDBE6E-6684-462b-AE98-9A39A1B200CC}",
      "{9D1B99B7-DAD8-440d-B4FB-1915332FBCC2}",
      "{C75CDBA2-3C86-481e-BD10-BDDA758F9DFF}",
      "{83F51BBA-48BE-4BB6-B96A-F4AAE4C462F9}",
      "{A436F67F-687E-4736-BD2B-537121A804CF}",
      "{710F7B0F-A679-4314-8E69-E868B660FAEA}",
      "{89CEAE14-DD0F-448E-9554-15781EC9DB24}",
      "{414C803A-6115-4DB6-BD4E-FD81EA6BC71C}",
      "{5962ABC1-427C-4651-B6FC-187A9F653AEF}",
      "{6E4EE9B5-F69D-4455-B430-40FA5F0DC988}",
      "{E3D43596-7E26-479E-B718-77CB3D9270F6}",
      "{A90F92B7-3C3F-4AEF-B281-31DD17BB73CA}",
      "{37839D69-6DA4-4125-B33A-30DE86345DF4}",
      "{FEB2C4AA-661E-483F-9626-21A8ACFD10F2}",
      "{D2064264-3162-4DB1-AFE0-167BEFBBCD9C}",
      "{32797608-0840-4645-BE1B-37AFFB18908A}",
      "{988D55BB-08DE-43C9-8D16-3751361E2A79}",
      "{6E14E6D6-3175-4E1A-B934-CAB5A86367CD}",
      "{3C33FD2E-6B21-4CD3-B41A-A7331D467617}",
      "{42DBA167-C25D-49CE-BBAF-DEC25E737DA8}",
      "{8704FEEF-A6A8-4E7E-B124-BD6122C66E2C}",
      "{E35A3B13-78CD-4967-8AC8-AA9FDA693EDE}",
      "{D8BCE5B9-67CF-4F3F-93AE-3ACC754C72EB}",
      "{A436F67F-687E-4736-BD2B-537121A804CF}",
      "{424CECC6-CEB1-4A5F-9A42-ADE64F035DEB}",
      "{A40F60B1-F1E1-452E-96A5-FF97F9A2D102}",
      "{EEAFE1E5-076B-430A-96D9-B567792AFA88}",
      "{EEEB604C-C1A7-4f8c-B03F-56F9C1C9C45F}",
      "{6F8071B2-5ECA-4A71-8E5D-7E2FE8174559}",
      "{1868D30B-72C7-41E8-9657-69C5DFE1C768}",
      "{9D380C34-58B7-4FF9-9DB8-05685AAD93D4}",
      "{3E9BC837-E48E-4964-AFFD-7AB40EBA5C50}",
      "{71EE298A-7B6D-4303-8438-C3E50567DA1F}",
      "{3F728815-C7E8-40EA-8D1A-F7B8E2382325}",
      "{D5D422B9-6976-4E98-8DDF-9632CB515D7E}",
      "{6D4839CB-28B4-4070-8CA7-612CA92CA3D0}",
      "{29AB47F0-C5A3-401F-8A84-3324F2DC8E46}",
      "{B0781FBD-8AD6-4658-A031-9815E1AC5047}",
      "{55B30AF2-7331-4436-9318-D9EA45A42F79}",
      "{B004600E-4A10-448B-8CDD-4ADB25A24042}",
      "{C88F84E5-AE23-44BD-922C-2ABEACACAF7A}",
      "{E92D47A1-D27D-430A-8368-0BAFD956507D}",
      "{BAD0FA60-09CF-4411-AE6A-C2844C8812FA}",
      "{2856A1C2-70C5-4EC3-AFF7-E5B51E5530A2}",
      "{E4A80DC6-8475-4AD9-9952-5E4437889563}",
      "{6B7AB1ED-B64E-4545-A8E7-F9E071E12B6F}",
      "{566BB063-0E28-4273-A748-690BE86A7E26}",
      "{53B17A98-5BF0-40BC-AAFF-850A357975AC}",
      "{24795E98-3D9E-4661-BA6F-BC6A4FB820CE}",
      "{E7004147-2CCA-431C-AA05-2AB166B9785D}",
      "{E517094C-06B6-419F-8FFD-EF4F57972130}",
      "{BB4FC2AD-DF12-4EE1-8AA7-2C0A26B5E2FB}",
      "{7861911B-4270-498A-8F7A-FCF0570F4877}",
      "{8B52057C-15DB-433E-957C-E279BC7D07E3}",
      "{528AB81B-D65A-4AB0-A2B6-82B51A087D01}",
      "{64BAA990-F1FC-4145-A7B1-E41FBBC9DA47}",
      "{D817481A-193E-4332-A4F3-E19132F744F0}",
      "{6369FC9E-FC8D-493F-AD87-D51FAB492705}",
      "{DB97D0DE-0AA1-413C-8398-92C7FA3F4A67}",
      "{4F46FDB9-B906-47BF-B3D5-C62E01B3C5EE}",
      "{98C4DE92-27C8-482C-8431-514828756E80}",
      "{D1E8F2D7-7794-4245-B286-87ED86C1893C}",
      "{C0C9A493-51CB-4F3F-A296-5B5E410C338E}",
      "{D1E7D876-6B86-4B35-A93D-15B0D6C43EAF}",
      "{C2E428EB-116E-41C0-9E84-B22DE9CCA42F}",
      "{C611CF88-969D-43E6-A877-D6D6439DD081}",
      "{C81D8576-F1B1-4E3A-9DC3-DF1B664962F0}",
      "{438363A8-F486-4C37-834C-4955773CB3D3}",
      "{F5E7D9AF-60F6-4A30-87E3-4EA94D322CE1}",
      "{5036764A-435D-40C9-869C-31085A3D741D}",
      "{ED1BD69A-07E3-418C-91F1-D856582581BF}",
      "{42D10994-A566-495D-A5E7-D0C6B5C6B35C}",
      "{AE2F1669-5B1F-47C5-B639-78D74DD0BCE4}",
      "{AC35A885-0F8F-4857-B7DA-6E8DFB43E6B3}",
      "{8FF6F5CA-4E30-4E3B-B951-204CAAA2716A}",
      "{DC635845-46D3-404B-BCB1-FC4A91091AFA}",
      "{9D1DE902-8058-4555-A16A-FBFAA49587DB}",
      "{3F019647-AC80-4859-B023-42D9DA71953F}",
      "{5B4F3B85-83F0-4BBF-9052-7A38B6B09634}",
      "{46235FF7-2CBE-4A84-BEDA-87348D1F7850}",
      "{20D6301E-0A14-4238-841D-45ECA567DB69}",
      "{FC3C2B77-6800-48C6-A15D-9D1031130C16}",
      "{34C821CA-6B55-44A0-8A9B-2EF471D6019E}",
      "{6821D775-9303-46DD-977A-2D97CA18B054}",
      "{2DA697D7-FED3-4DE2-A174-92A2A12F9688}",
      "{B6F5C6D8-C443-4B55-932F-AE11B5743FC4}",
      "{285F722C-0E45-47DE-B38E-5B3B10FA4A7C}",
      "{95EEB814-D454-4176-A6B5-D708CB48064F}",
      "{6663B59B-E9CE-44CA-8654-7BE9060D653D}",
      "{DAE3B13B-5097-4EAE-BC26-C463377BD80E}",
      "{DA200FDD-DE3D-4958-8465-C4FBC869544B}",
      "{B1AFAD6F-9192-421F-9DFF-60A59571366B}",
      "{65514800-1E09-48D6-B520-3DC70572E891}",
      "{D160035A-CFF0-49C6-BE19-B9EFDE4AEBF2}",
      "{7ED7BF91-D145-480A-B206-6891576F6935}",
      "{B1A4A13D-4665-4ED3-9DFE-F845725FBBD8}",
      "{741CFE3A-1C0B-4A7D-8E08-5D78C911C09D}",
      "{F4D304D9-7647-4253-957E-44286B8631F4}",
      "{BC5DD87B-0143-4D14-AAE6-97109614DC6B}",
      "{A36CD345-625C-4d6c-B3E2-76E1248CB451}",
      "{B2B7B1C8-7C8B-476C-BE2C-049731C55992}",
      "{D7D5F438-26EF-45AB-AB89-C476FBCF8584}",
      "{348A1F5B-07B3-4436-9A47-FFE44EFE856E}",
      "{55065080-504F-43BB-BE00-36B80D7D39A5}",
      "{B47A593F-4E09-42EC-883A-E89860DAECB2}",
      "{5C90D8CF-F12A-41C6-9007-3B651A1F0D78}",
      "{28FE073B-1230-4BF6-830C-7434FD0C0069}",
      "{C422BF2C-E570-4D3E-8718-7C641B190DB2}",
      "{39011DEC-8956-401E-8369-421D402FFF52}",
      "{8B4EE87E-6D40-4C91-B5E8-0DC77DC412F1}",
      "{D17A3B70-B75E-4C49-83D6-C17DDF65B35F}",
      "{7504A7B0-003E-4875-A454-B627E127E9D9}",
      "{06CE2B24-EC8C-4847-AF33-098255B5D32D}",
      "{44EB02F5-16E5-42BD-9183-C23EF7620CF3}",
      "{46A99EAE-98DA-4BE5-94C3-D41BA4C266DA}",
      "{B8DBED1E-8BC3-4d08-B94A-F9D7D88E9BBF}",
      "{6470E292-3B55-41DC-B5EB-91C34C5ACB5D}",
      "{7C960641-0A27-45C6-96F8-BE4E04A4CC2C}",
      "{092FCD1C-5203-4BD1-B4F4-0F0C6B237A6A}",
      "{0CCFF6E8-B4D1-416F-8198-B223BA8B1991}",
      "{25E11B5A-4817-4296-A260-235AE77B1708}",
      "{A1EF28FB-74A8-4157-91E9-9C164CAB10F8}",
      "{FDEA674C-478D-455F-9894-D6D4CD4BB304}",
      "{71677768-D5DA-4785-8A44-2DFFE33CF70A}",
      "{9652051B-BC94-4588-A84B-B9B34660FB5E}",
      "{456E4C16-227D-48E4-BA3B-52D1B15CB196}",
      "{B9A03B7B-E0FF-4FB3-BA83-762E58A1B0AA}",
      "{B1CB7E99-4685-45CB-867E-2FB58EDA0A39}",
      "{33C9F24B-1D92-4632-A915-81E3BB1D5D6B}",
      "{A7D99092-CFCA-AF69-9B61-B4A8784B5F8C}",
      "{6BBA26E9-AB03-4FE7-831A-3535584CA002}",
      "{292F0F52-B62D-4E71-921B-89A682402201}",
      "{0F7C2E47-089E-4d23-B9F7-39BE00100776}",
      "{AC13BA3A-336B-45a4-B3FE-2D3058A7B533}",
      "{f32502b5-5b64-4882-bf61-77f23edcac4f}",
      "{0DDA7620-4F8B-43B3-8828-CA5EE292FA3B}",
      "{4127C2C0-0AC7-4947-9CC1-AACBEFC6EC02}",
      "{DE77FE3F-A33D-499A-87AD-5FC406617B40}",
      "{03D15668-8F54-47C0-BFF2-6F966E4DF052}",
      "{84814E6B-2581-46EC-926A-823BD1C670F6}",
      "{4EDBB1CC-C418-443B-A0B0-A94DEA1ED8B2}",
      "{55C48613-A2DF-4286-9467-E3BCB23CD8F4}",
      "{872B1C80-38EC-4A31-A25C-980820593900}",
      "{70F9BF10-3729-4333-BCBE-5218F69582FA}",
      "{A535F266-291E-447F-ABE6-0BE17D0CB036}",
      "{19484EF1-E27A-43D1-9EEB-685D41888AC8}",
      "{FF075778-6E50-47ed-991D-3B07FD4E3250}",
      "{4D304678-738E-42a0-931A-2B022F49DEB8}",
      "{1EC71BFB-01A3-4239-B6AF-B1AE656B15C0}",
      "{1B57D761-768E-4FB8-A6BB-057A977A7C81}",
      "{5ACE69F0-A3E8-44eb-88C1-0A841E700180}",
      "{C4E9E8A4-EEC4-4F9E-B140-520A8B75F430}",
      "{0DF3F266-B52E-4309-B3CC-233607DF4E50}",
      "{9603DE6D-4567-4b78-B941-849322373DE2}",
      "{4A70EF07-7F88-4434-BB61-D1DE8AE93DD4}",
      "{3C023AD6-4740-479A-8B7A-B5718F240268}",
      "{A5AB9D5E-52E2-440e-A3ED-9512E253C81A}",
      "{E06F04B9-45E6-4AC0-8083-85F7515F40F7}",
      "{787D1A33-A97B-4245-87C0-7174609A540C}",
      "{97486FBE-A3FC-4783-8D55-EA37E9D171CC}",
      "{117BBDE7-472E-4DCD-BAAE-410A0794A335}",
      "{6FE8E073-D159-4419-93E2-CE2C5B078562}",
      "{DCEA910B-3269-4F5B-A915-D59293004751}",
      "{AE856388-AFAD-4753-81DF-D96B19D0A17C}",
      "{85D645CF-0F3B-477A-A9C9-194917F1A75B}",
      "{2EA3D6B2-157E-4112-A3AB-BF17E16661C3}",
      "{6ECB39BD-73C2-44DD-B1A0-898207C58D8B}",
      "{962CB079-85E6-405F-8704-1C62365AE46F}",
      "{904822F1-6C7D-4B91-B936-6A1C0810544C}",
      "{8C6027FD-53DC-446D-BB75-CACD7028A134}",
      "{B0069CFA-5BB9-4C03-B1C6-89CE290E5AFE}",
      "{C23415D8-FE94-4F52-B5C4-0FFA2202C6D9}",
      "{F07C2CF8-4C53-4EC3-8162-A6221E36EB88}",
      "{8D4B1DDC-0CB5-4908-B740-A385C2F3B6A9}",
      "{B7B82520-8ECE-4743-BFD7-93B16C64B277}",
      "{35021DFB-F9CA-402A-89A2-47F91E506465}",
      "{D7670221-BF9B-4DFF-B26B-5BE55A87329F}",
      "{11B83AD3-7A46-4C2E-A568-9505981D4C6F}",
      "{C6363DC5-17A4-4E36-B701-9EC719390D48}",
      "{C7AE4EC3-9C13-4213-8457-74D16B353F91}",
      "{179C56A4-F57F-4561-8BBF-F911D26EB435}",
      "{8EE94FD8-5F52-4463-A340-185D16328158}",
      "{350C97B0-3D7C-4EE8-BAA9-00BCB3D54227}",
      "{29FA38B4-0AE4-4D0D-8A51-6165BB990BB0}",
      "{43CDF946-F5D9-4292-B006-BA0D92013021}",
      "{087A66B8-1F0F-4a8d-A649-0CFE276AA7C0}",
      "{06C4BA69-5210-4707-B5BE-E26D487E1854}",
      "{14CF9AF8-10A6-4FA7-9E57-D22DBD644C77}",
      "{9AB1B6EC-AEA4-4D78-ADDB-0291BF7230F4}",
      "{547607B0-3294-4ECA-8F5E-921404676CBB}",
      "{13133E99-B0D5-4143-B832-AAD55C62A41C}",
      "{92F7E378-0F27-4D1E-ACAE-2AA7E546D082}",
      "{3082CB96-66E8-456D-8326-118A4F5DC0C6}",
      "{CFD917BE-F1F6-410E-ABEC-9EC819507D0D}",
      "{5601F151-A69F-4E30-8C60-37928124CD07}",
      "{394C7F61-1C1F-11EA-9634-3863BB3CB5AC}",
      "{FDBB153D-8F11-4C93-BC0A-9BBF95B26427}",
      "{EC720706-3F19-4B7F-BDDD-E31D9B3921D2}"

function start-UWP-removal {
$ProgressPreference = 'SilentlyContinue'
ForEach ($App in $UWPAppList) {
 $PackageFullName = (Get-AppxPackage $App -allusers).PackageFullName
 $ProPackageFullName = (Get-AppxProvisionedPackage -online | Where-Object {$_.Displayname -eq $App}).PackageName
 write-host $PackageFullName
 Write-Host $ProPackageFullName
 if ($PackageFullName)
 {
 Write-Host "Removing Package: $App"
 remove-AppxPackage -package $PackageFullName 
 }
 if ($ProPackageFullName)
 {
 Write-Host "Removing Provisioned Package: $ProPackageFullName"
 Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName -allusers
}}
$ProgressPreference = 'Continue'
Write-Output "Removed UWP apps."
}

function start-GAP-removal {
ForEach ($App in $GAPAppList) {
Get-Package "$App" | Uninstall-Package 
Get-Package "$App" | ForEach-Object { & $_.Meta.Attributes['UninstallString'] /S } -ErrorAction SilentlyContinue
}            
Write-Output "Removed apps using GAP."
}

function start-GUID-removal {
ForEach ($App in $GUIDAppList) {
  Start-Process msiexec -Wait -ArgumentList '/X $App /qn /norestart'
}            
Write-Output "Removed apps using GUID."
CMD /C "C:\Program Files\HP\Documentation\Doc_Uninstall.cmd"
"c:\Program Files\HP\HP ProtectTools Security Manager\Bin\setup.exe"
Start-Process "C:\Program Files (x86)\InstallShield Installation Information\{6468C4A5-E47E-405F-B675-A70A70983EA6}\setup.exe" -Argumentlist '-runfromtemp -l0x0409  -removeonly'
C:\Program Files\McAfee\MSC\mcuihost.exe /body:misp://MSCJsRes.dll::uninstall.html /id:uninstall
}

############################################################################

function start-main-menu {
do { $myInput = (Read-Host 'Remove HP bloatware?(Y/N)').ToLower() } while ($myInput -notin @('Y','N'))
if ($myInput -eq 'y') {
start-UWP-removal
Write-Output ''
start-GAP-removal
Write-Output ''
start-GUID-removal
Write-Output ''
Write-Output "Completed bloatware removal."
pause
}
if ($myinput -eq 'n') {
Write-Output ''
Write-Output "Not removing bloatware removal."
Write-Output ''
pause
}}



#############################################################################

start-main-menu