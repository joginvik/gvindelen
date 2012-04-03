
{*******************************************************}
{                                                       }
{             Copyright (C) 2000 - 2001                 }
{         Dmitriy Kovalenko (ibsysdba@i.com.ua)         }
{                         &                             }
{           Pavel Shibanov (ib_db@i.com.ua)             }
{                   Kiev, Ukraine                       }
{                                                       }
{*******************************************************}

const
  APP_NAME       = 'FIBPlus Demo Pack';
  INI_FILE_NAME  = 'fibplus_demo.ini'; // ���� ��������

  SEARCH_DELAY     = 1500; //��������� �������� ��� ������
  INTERNAL_MESSAGE = $0400 {WM_USER} + 100; //"����������" ����������������� ������


  CR                 = #13#10; //������� �������
  DLL_NAME                = 'FIBPLUS_DLL';
  DLL_PATH                = 'DLL\';
  DLL_EXT                 = '.DLL';
  DLL_ERROR_LOAD          = '���������� ��������� ';
  GET_PROC_ADDRESS_FAILED = '����������� ����������� DLL ' + CR +
                            '��� � DLL �� ������ ����� ����������� �������.';

  UNDER_CONSTRUCTION = 'Sorry,... coming soon.' + CR + 'Under construction.';

  INSERT_RECORD = 'Insert new record';
  EDIT_RECORD   = 'Edit current record';