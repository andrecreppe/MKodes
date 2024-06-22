function simmma(ti,ui)
% Simulacao de um sistema massa-mola-amortecedor - 2 GDLs

f1=figure(1); clf; ui=.35*ui/max(max(ui));
yax=1:size(ui,2); xax=yax*0; yb=1+min([ui(:,1);0]); yt=max(ui(:,size(ui,2)))+max(yax);
hp=plot(xax,yax+ui(1,:),'wo',[0 0],[yb yt],'w-',xax,yax+ui(1,:),'rs',xax,yax+ui(1,:),'k-');
for jd=1:length(yax) 
    hl=line([-max(ti) 0],[yax(jd)+ui(1,jd) yax(jd)+ui(1,jd)]); 
    set(hl,'linestyle','--','color','w'); 
    text(.7,yax(jd)+ui(1,jd),num2str(jd)); 
end
set(hp(3),'markersize',15), set(hp(4),'markersize',2), set(gca,'visible','off'),
axis([-max(ti) 0 yb yt]),
for id=1:size(ui,1)
    if ti(id)>0 ti=ti-max(diff(ti)); end
    set(hp(3),'ydata',yax+ui(id,:)),
    ydata=[ones(id,1)*yax+ui(1:id,:);ones(1,length(yax))*NaN]; xdata=[ti(1:id)*ones(1,length(yax));ones(1,length(yax))*NaN];
    set(hp(4),'ydata',ydata(:),'xdata',xdata(:))
    pause(0.1*max(diff(ti))),
end
