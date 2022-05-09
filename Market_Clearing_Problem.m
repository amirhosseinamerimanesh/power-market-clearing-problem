% Market Clearing Problem
clc
clear
close all
% bid power in Mwh , bid price in $/Mwh
%   company   bid power     bid price
data = [
    1         100           12.5
    1         100           14
    1         50            18
    2         200           10.5
    2         200           13
    2         100           15
    3         50            13.5
    3         50            14.5
    3         50            15.5
    4         100           10
    4         100           15
    ];
%   num   color

company_color = [
    1     'r'
    2     'b'
    3     'g'
    4     'm'
    ];

offers = [
    1     400
    2     600
    3     875
    4     920
    ];

sortdata = sortrows(data,3);
num_co = max(data(:,1));
sizedata = size(data(:,1));
bidpower = sortdata(:,2);
plotbidpower = [0 ;bidpower];
for i = 2:sizedata(1)+1
    plotbidpower(i) = plotbidpower(i)+plotbidpower(i-1);
end
max_offer = max(offers(:,2));
for i = 1:sizedata(1)
    bid_power_range = plotbidpower(i):plotbidpower(i+1);
    bid_pr(plotbidpower(i)+1:plotbidpower(i+1)+1,1) = bid_power_range;
    for j = 1:num_co
        if sortdata(i,1) == j
            pcl = company_color(j,2);
        end
    end
    hold on
    price_arrays = sortdata(i,3)*ones(1,size(bid_power_range,2));
    bid_pr(plotbidpower(i)+1:plotbidpower(i+1)+1,2) = sortdata(i,3)*ones(1,size(bid_power_range,2));
    bid_pr(plotbidpower(i)+1:plotbidpower(i+1)+1,3) = sortdata(i,1)*ones(1,size(bid_power_range,2));
    plot(bid_power_range,price_arrays,'color',pcl,'linewidth',2)
    grid on
end

title('Suppliers Bids')
xlabel('Quantity(MWh)','fontweight','bold' )
xstep = 100;
xticks(0:xstep:plotbidpower(sizedata(1))+xstep);

ylabel('Price($/Mwh)','fontweight','bold');
mindata = min(data(:,3)) - 2;
maxdata = max(data(:,3)) + 2;
ylim([mindata maxdata]);
num_offers = max(offers(:,1));

for i = 1:num_offers
    xline(offers(i,2),'linewidth',2);
    mcp_location = find(bid_pr == offers(i,2));
    mcp(i) = bid_pr(mcp_location,2);
    yl = yline(mcp(i),'--','MCP','linewidth',2,'color','black');
    yl.LabelHorizontalAlignment = 'center';
end
