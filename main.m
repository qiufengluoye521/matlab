close all;
clear all;
clc;

data_load = load('c_result.txt');

ppg_data_real = data_load(:,1);
ppg_data_img = data_load(:,2);
ppg_data = ppg_data_real .* ppg_data_real + ppg_data_img .* ppg_data_img;
ppg_data = sqrt(ppg_data);
gsensor_data_real = data_load(:,3);
gsensor_data_img = data_load(:,4);
gsensor_data = gsensor_data_real .* gsensor_data_real + gsensor_data_img .* gsensor_data_img;
gsensor_data = sqrt(gsensor_data);

len_data = length(ppg_data);


ppg_data_reshape = reshape(ppg_data,166,len_data/166);
ppg_data_reshape = ppg_data_reshape';
gsensor_data_reshape = reshape(gsensor_data,166,len_data/166);
gsensor_data_reshape = gsensor_data_reshape';

out_data = [ppg_data(:,1),gsensor_data(:,1)];
dlmwrite('ppg_gsensor_data.txt', out_data,'delimiter','\t'); 


fs = 25*60;             % sample rate /minute
T = 1/fs;
Nw=100;                                 %窗函数长 window length 推荐：256
low_fre = 0.75;
high_fre = 3.5;
fn = (low_fre*60:1:high_fre*60);
Ts = length(ppg_data_reshape(:,1));


figure;
tn=(1:Ts)*Nw/2/fs;          % 三维绘图的时间轴
[T,F]=meshgrid(tn,fn);
mesh(T,F,abs(ppg_data_reshape.'));  %三维绘图
view(0,90);
axis tight;
title('ppg三维时频图'); 
ylabel('Frequency(Hz)'); 
xlabel('Time(minute)'); 
%}

figure;
tn=(1:Ts)*Nw/2/fs;          % 三维绘图的时间轴
[T,F]=meshgrid(tn,fn);
mesh(T,F,abs(gsensor_data_reshape.'));  %三维绘图
view(0,90);
axis tight;
title('gsensor三维时频图'); 
ylabel('Frequency(Hz)'); 
xlabel('Time(minute)'); 
%}


%{
% 不用mesh 改用matlab 的imagesc 图像更加清晰
fn = (low_fre*60:1:high_fre*60);
tn=(1:Ts)*Nw/2/fs;          % 三维绘图的时间轴
figure
imagesc(tn,fn,abs(data_reshape'));
set(gca,'YDir','normal');
colorbar;
xlabel('时间 t/s');
ylabel('频率 f/Hz');
title('颜色时频图');
%}


% 不用mesh 改用matlab 的imagesc 图像更加清晰
fn = (low_fre*60:1:high_fre*60);
tn=(1:Ts)*Nw/2/fs;          % 三维绘图的时间轴
figure
%imagesc(tn,fn,abs(data_reshape'));
pcolor(tn,fn,abs(ppg_data_reshape'));
set(gca,'YDir','normal');
colorbar;
xlabel('时间 t/s');
ylabel('频率 f/Hz');
title('ppg颜色时频图');
%}

fn = (low_fre*60:1:high_fre*60);
tn=(1:Ts)*Nw/2/fs;          % 三维绘图的时间轴
figure
%imagesc(tn,fn,abs(data_reshape'));
pcolor(tn,fn,abs(gsensor_data_reshape'));
set(gca,'YDir','normal');
colorbar;
xlabel('时间 t/s');
ylabel('频率 f/Hz');
title('gsensor颜色时频图');


