# brakingsystem
OpenComputersによるImmersiveRailroadingの停車制御<br>
<br>
ブレーキ制動プログラムと発車プログラム<br>
brakingsystem.luaがブレーキ制動プログラム<br>
100mで30km/hに制御する。むりやり比例制御もどき<br>
0～100m、20m間隔でdetector,controlerを隣り合わせて計6セット配置すること<br>
<br>
stopping.luaが停止・発車プログラム（コマンドライン引数：停車時間[s]）<br>
ブレーキ制動プログラムによって30km/hで制御範囲に入ることを想定している<br>
controlerを10mごとに計3つ配置して動作確認
