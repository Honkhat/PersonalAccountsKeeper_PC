﻿unit PAK_Language;

interface
type
  TLanguageType = (ltnone, lteng, ltchn{, ltjpn});
  TLangStrIndex = (lsiOpen, lsiEdit, lsiRename, lsiDelete, lsiMove,//menu related
                  lsiNewAc, lsiNewFolder, lsiParentFolder, lsiSearch, lsiClickEdt,
                  lsiClickIco2Edt, lsiError, lsiUsrEmpty, lsiEditShareInUse,
                  lsiSetPwdFstUse,lsiConfirm, lsiCancel, lsiLogIn, lsiPwdNotMatch,
                  lsiPwdTooShort,lsiWrongPwd, lsiAcInfo, lsiUsr, lsiPwd, lsiUrl, lsiFolder,
                  lsiNoteShort, lsiNoteLong, lsiSave, lsiSaveN, lsiBack, lsiOprn,
                  lsiDetail, lsiCurPath, lsiTypeKWord, lsiNoEmpty, lsiVisitUrl,
                  lsiErrAcSaveOrN, lsiSureOprn, lsiAllAcGone, lsiWarn, lsiFdrNSet,lsiFdbk,
                  lsiSaveSuc, lsiChng, lsiSuc, lsiFail, lsiNewTokn, lsiReset, lsiFaq01Q,
                  lsiFaq01A, lsiFaq01A2, lsiFaq02Q, lsiFaq02A,lsiFaq02A2,lsiFaq03Q, lsiFaq03A,
                  lsiFaq03A2, lsiFaq03A3,lsiFaq04Q, lsiFaq04A, lsiFaq05Q, lsiFaq05A, lsiSOS1,
                  lsiSOS2, lsiSOS3, lsiUILang, lsiSlogan, lsiAbtAuthorTip,lsiAbtAuthor, lsiAbtPak,
                  lsiAbtPakVal, lsiAuthorThks, lsiClose, lsiDonate3ks, lsiDonateTip1);

const
  LanguageName: array[lteng..ltchn{ltjpn}] of string = ('English','中文简体'{,'日本語'});

  LangEngArray: array[lsiOpen..lsiDonateTip1] of string = ('Open', 'Edit', 'Rename', 'Delete', 'Move To',
                  'New Account', 'New Folder', 'Parent Folder', 'Search', 'Click here to edit', 'Click the icon to edit',
                  'Error', 'User name couldn''t be empty!', 'The contents in Edit control is invalid!',
                  '* Just set one password if first use', 'Confirm:', 'Cancel', 'Log In',
                  'The passwords don''t match!', 'The length of PAK password should be >=3 at least!',
                  'Wrong Password for PAK!', 'Account Information', 'User', 'Password', 'URL', 'Folder',
                  'Short Note','Long Note', 'Save', 'Don''t Save', 'Back', 'Operation', 'Details', 'Current Path:',
                  'type the key word', 'Whatever you set can''t be empty!', 'Visit URL', 'Please choose Save or Don''tSave the Info!',
                  'Are you sure about this operation?', 'All the accounts under this folder will be deleted!', 'WARN',
                  'You may want to select one folder for your account :)', 'Feedback', 'Save Sucess!', 'Change', 'Success',
                  'Fail', 'New Token', 'Reset', 'How should I backup/recover my account data?', ' There''re two files named "PAK" and "EMERGENCY", backup either is ok.',
                  'To recover, just put either in the .exe directory.', 'What if others get my PAK data, can they open it and see what''s inside?',
                  'No. Because PAK uses the 128-bit encryption algorithem.', 'In general, to achieve that others have to know your PAK token or peek them while u r absent leaving PAK logged in.',
                  'Tell me some tricks when using PAK.', '1. Click the left rear leg of the cute lion, the content can be invisible and you can drag it like a desktop icon;',
                  '2. As PAK won''t create task on the task-bar, in order to find it you may have to minimize the windows in-front one by one;', '3. One menu will popup if you hover the mouse over the left edge.',
                  'Is the source code of PAK public?','[http://down.51cto.com/data/2200472]', 'I did''t backup, and both my PAK data files are broken/missing, what should I do?', 'This is bad. But still I''ll try my best to help you.',
                  '1. Dude,  CALM IT DOWN.', '2. THINK. Try to figure out the best move.', '3. Contact worksdata@163.com        (May absent).',
                  'UI Language', '-- Secure, Fast, Small, name any three', 'About Author', ' - I''m a fan of Dolph Lundgren'+#13#10+
                  ' - Currently work in Beijing, China'+#13#10+' - Love sports, e-teque and beauty'+#13#10+' - Any question, contact worksdata@163.com',
                  'About PAK', '- Full Name: Personal Accounts Keeper'+#13#10+'- Develop Skills:'+#13#10+'      - Tools: Delphi 2010 + Visual Studio 2010'+#13#10+
                  '      - Storage: sqlite3'+#13#10+'- Advantage:'+#13#10+'      - Data encrypted'+#13#10+'      - Only store in local'+#13#10+
                  '      - Privacy convenience', 'Thanks to you, Rayshelle! Without you, it would be just an idea. Yeah, i mean it.', 'Close',
                  'Thanks for your donation', 'Encourage me to do better');
  LangChnArray: array[lsiOpen..lsiDonateTip1] of string = ('打开', '编辑', '重命名', '删除', '移动到',
                '添加账户', '新建文件夹', '父文件夹', '搜索', '点击编辑', '点击图标编辑', '错误', '用户名不可为空!',
                '编辑框的内容输入不合法!', '* 第一次使用只需设置一个口令即可', '确认:', '取消', '登陆',
                '两次输入的口令不匹配!', 'PAK 口令至少3个字符!', 'PAK口令错误!', '账户信息', '用户名', '密码', '网址',
                '文件夹', '短标记', '长标记', '保存', '不保存', '返回', '操作', '详细', '当前路径:', '输入关键字查找',
                '您设置的东西不可为空!', '访问网址', '请选择保存或者不保存账户信息!', '您确定要这么做吗?',
                '此文件夹下的所有账户也会被删除!', '警告', '同学, 给这个账户设置个文件夹吧!', '反馈', '保存成功!',
                '修改', '成功', '失败', '新口令', '重置','我应该如何备份/恢复我的账户数据?', '程序目录下有两个文件PAK和EMERGENCY, 备份任何一个文件皆可。',
                '只需将备份文件覆盖掉程序目录中的同名文件，即可恢复数据。', '如果别人获取了我的PAK数据文件, 是不是可以打开看到我的账户数据?',
                '不能。因为PAK使用了128位的加密算法对您的账户数据进行了加密。', '一般来说，其他人只能通过两种途径获取您的数据: 知道了PAK口令 和 登陆PAK后偷看。',
                '请告诉我一些关于PAK使用的小技巧吧', '1. 点击小狮子的左后腿, 可以将内容界面隐藏, 类似桌面的图标, 可以拖来拖去;',
                '2. PAK不会在任务栏创建图标, 所以如果它不是最前面的窗口，就挨个最小化桌面窗口查找吧;', '3. 鼠标移动到窗口的左边界, 会弹出一个操作菜单.',
                'PAK源代码公开吗?','http://down.51cto.com/data/2200472', '我没有备份, 而且2个PAK数据文件也都损坏了, 怎么办?', '凉拌。不过我还是会尽我所能帮助你的。',
                '1. 哥们儿, 先去去火;', '2. 思考。 冷静分析当前最好怎么做;', '3. 敲我门去-->worksdata163.com    (可能不在哦)。',
                '界面语言', '-- 安全, 速度, 小巧, 满足任意一个', '关于作者', ' - 我喜欢看Delph Lundgren的电影'+#13#10+
                  ' - 现在居住在中国北京'+#13#10+' - 喜欢运动, 电子技术和美的事物'+#13#10+' - 任何疑问, 联系worksdata@163.com',
                  '关于PAK', '- 全名: 个人账户管家'+#13#10+'- 开发技能:'+#13#10+'      - 工具: Delphi 2010 + Visual Studio 2010'+#13#10+
                  '      - 存储: sqlite3'+#13#10+'- 优势:'+#13#10+'      - 数据加密'+#13#10+'      - 只在本地存储,不联网'+#13#10+
                  '      - 隐私保护', '喂, Rayshelle, 不谢! 如果没有你一直督促我, 它肯定只是一个想法。是的，确实是这么回事。', '关闭',
                  '谢谢您的捐赠', '鼓励我做的更好吧');



implementation
end.
