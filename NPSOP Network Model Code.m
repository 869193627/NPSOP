 clc;
 clear all;
 close all;
maxrun=1;                         %运行仿真次数
for runtimes=1:1:maxrun            
    clc;   
    close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 网络参数 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xm=100;                        %目标监测区域   100mx100m
    ym=100;
    tranr=xm/2;                    %节点通信半径   L/2 保证能与基站通信
    sink.x=0.5*xm;                 %基站位置       位于目标区域中心
    sink.y=0.5*ym;
    p=0.1;                         %簇头占比
    N=100;                         %网络节点数
    packagelen=4000;               %数据包大小
    packagectr=200;                %控制包大小
    deadn(runtimes)=0;              %死亡节点数
    fdnr(runtimes)=0;               %首节点死亡轮数
    hdnr(runtimes)=0;               %一半节点死亡轮数
    ldnr(runtimes)=0;               %末节点死亡轮数
%---------------------能耗模型----------------------------------------
    InitEn=1;                      %初始能量1J
    Etx=50*0.000000001;            %发射单位数据能耗
    Erx=50*0.000000001;            %接收单位数据能耗
    Efs=10*0.000000000001;         %放大器电路参数
    Emp=0.0013*0.000000000001; 
    EDA=5*0.000000001;             %数据融合能耗
    d0=sqrt(Efs/Emp);              %计算d0  初始距离
%%%%%%%%%%%%%%%%%%%%%%%%% END OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%
%*************************创建一个无线传感器网络******************
     for i=1:1:N
        S(i).xd=rand(1,1)*xm;      %rand(1,1)*xm;matrix_X(i)      %节点坐标  这两行换成注释的东西
        S(i).yd=rand(1,1)*ym;      %;matrix_Y(i)
        S(i).energy=InitEn;        %节点当前能量  
        S(i).id=i;                 %节点的ID号
        S(i).type=0;               %节点类型  0：普通节点  1：簇头节点
        S(i).state=0;              %节点状态  0：存活      1：死亡
        S(i).ch=0;                 %节点对应的簇头序号
        S(i).dis=tranr;            %节点与簇头或簇头与基站之间的距离
        S(i).csize=0;              %簇大小（包含的节点数）
        S(i).dch=0;
        S(i).g=0;
        C=struct('xd',[1 N],'yd',[1 N],'dis',[1 N],'energy',[1 N], 'id',[1,N],'csize',[1,N]);
        plot(S(i).xd,S(i).yd,'o')
        hold on
    end

    S(N+1).xd=sink.x;               %基站位置     
    S(N+1).yd=sink.y;
    plot(S(N+1).xd,S(N+1).yd,'x');  %画出基站节点
%---------------------------------初始网络生成结束-----------------------
end