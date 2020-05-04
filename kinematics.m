function kinematics()
global axes2handles;
global edit1 edit2 edit3 edit4 edit5 edit6;
global robot;
global pre cur;
q1=get(edit1,'string');
q1=str2double(q1);
q2=get(edit2,'string');
q2=str2double(q2);
q3=get(edit3,'string');
q3=str2double(q3);
q4=get(edit4,'string');
q4=str2double(q4);
q5=get(edit5,'string');
q5=str2double(q5);
q6=get(edit6,'string');
q6=str2double(q6);
cur=[q1 q2 q3 q4 q5 q6];
cur=cur/180*pi;
% [q1,q2,q3,q4,q5,q6]
col=1e-5;
if max(abs(cur(:)-pre(:))) >= col
    now= jtraj(pre,cur,40);
    axes(axes2handles);
    for i=1:3:40
     robot.plot(now(i,:));
    end
end
robot.plot(cur);
pre=cur;
hold on;

