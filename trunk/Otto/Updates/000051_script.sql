delete from bonuses;
-- Levakova
update orders set client_id = -183601, adress_id = -183601, account_id=12684 where order_id = 3169;
update accopers set account_id = 12684 where account_id = 16344;
update accrests set account_id = 12684 where account_id = 16344;
update ordermoneys om set om.account_id = 12684 where om.account_id = 16344;
delete from clients c where c.client_id=5090;
delete from accounts a where a.account_id = 16344;
delete from adresses a where a.adress_id = 1546;

-- Lukomskiy
update orders set client_id = 4349, adress_id = 695, account_id=14792 where order_id = 3929;
update ordermoneys om set om.account_id = 14792 where om.account_id = 17124;
update accopers set account_id = 14792 where account_id = 17124;
update accrests set account_id = 14792 where account_id = 17124;
delete from clients c where c.client_id=5395;
delete from accounts a where a.account_id = 17124;
delete from adresses a where a.adress_id = 1923;

-- Maruk
update orders set client_id = 3931, adress_id = 944, account_id=14074 where order_id = 1142;
update ordermoneys om set om.account_id = 14074 where om.account_id = 14458;
update accopers set account_id = 14074 where account_id = 14458;
update accrests set account_id = 14074 where account_id = 14458;
delete from clients c where c.client_id=4143;
delete from accounts a where a.account_id = 14458;
delete from adresses a where a.adress_id = 466;
update orders set client_id = 3931, adress_id = 944, account_id=14074 where order_id = 2699;
update ordermoneys om set om.account_id = 14074 where om.account_id = 15879;
update accopers set account_id = 14074 where account_id = 15879;
update accrests set account_id = 14074 where account_id = 15879;
delete from clients c where c.client_id=4911;
delete from accounts a where a.account_id = 15879;
delete from adresses a where a.adress_id = 1339;
update orders set client_id = 3931, adress_id = 944, account_id=14074 where order_id = 2991;
update ordermoneys om set om.account_id = 14074 where om.account_id = 16141;
update accopers set account_id = 14074 where account_id = 16141;
update accrests set account_id = 14074 where account_id = 16141;
delete from clients c where c.client_id=5023;
delete from accounts a where a.account_id = 16141;
delete from adresses a where a.adress_id = 1468;

-- Savelova
update orders set client_id = 4034, adress_id = 355, account_id=14266 where order_id = 1452;
update ordermoneys om set om.account_id = 14266 where om.account_id = 14724;
update accopers set account_id = 14266 where account_id = 14724;
update accrests set account_id = 14266 where account_id = 14724;
delete from clients c where c.client_id=4315;
delete from accounts a where a.account_id = 14724;
delete from adresses a where a.adress_id = 649;


execute procedure bonus_make('������ ����� �������������',  6);
execute procedure bonus_make('������� �������� ����������',  6);
execute procedure bonus_make('�������� ������� ����������',  6);
execute procedure bonus_make('����� ���� ����������',  6);
execute procedure bonus_make('�������� ������ �������������',  6);
execute procedure bonus_make('��������� �������� ���������',  6);
execute procedure bonus_make('��������� ����� ����������',  6);
execute procedure bonus_make('�������� ������� ����������',  6);
execute procedure bonus_make('����� ����� ������������',  6);
execute procedure bonus_make('��������� ��������� ����������',  6);
execute procedure bonus_make('����� �������� �����������',  6);
execute procedure bonus_make('������ ������ ���������',  6);
execute procedure bonus_make('��������� ����� ����������',  6);
execute procedure bonus_make('���������� ���� ��������',  6);
execute procedure bonus_make('�������� ����� ����������',  6);
execute procedure bonus_make('�������� ����� ��������',  6);
execute procedure bonus_make('�������� ������ ����������',  6);
execute procedure bonus_make('������ ������� ����������',  6);
execute procedure bonus_make('������ ������� ����������',  6);
execute procedure bonus_make('����� ����� �������������',  6);
execute procedure bonus_make('������ ����� ����������',  6);
execute procedure bonus_make('������ ����� ����������',  6);
execute procedure bonus_make('���� �������� ������������',  6);


execute procedure bonus_make('����� ������� ����������',  7);
execute procedure bonus_make('��������� ������� ������������',  7);
execute procedure bonus_make('��������� ������ ����������',  7);
execute procedure bonus_make('��������� ������� ����������',  7);
execute procedure bonus_make('������� ������� ����������',  7);
execute procedure bonus_make('���������� ������ �������������',  7);
execute procedure bonus_make('��������� ������ ����������',  7);
execute procedure bonus_make('�������� ������� �������������',  7);

execute procedure bonus_make('������ ���� ������������',  8);
execute procedure bonus_make('������ ���� ������������',  8);
execute procedure bonus_make('�������� ������� �������������',  8);
execute procedure bonus_make('�������� ������� �������������',  8);



