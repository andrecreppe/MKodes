% fcnrot3d.m
function fcnrot3d(R, canRecord, fileName)
    figure;
    
    if canRecord
        myVideo = VideoWriter(fileName);
        myVideo.FrameRate = 30;
        open(myVideo)
    end

    set(1,'position',[1238 281 683 704])
    lx=5; ly=3; lz=1;
    vi(:,1)=[lx;ly;-lz];
    vi(:,2)=[-lx;ly;-lz];
    vi(:,3)=[-lx;-ly;-lz];
    vi(:,4)=[lx;-ly;-lz];
    vi(:,5)=[lx;ly;lz];
    vi(:,6)=[-lx;ly;lz];
    vi(:,7)=[-lx;-ly;lz];
    vi(:,8)=[lx;-ly;lz];

    hbk0=line([vi(1,1:4) vi(1,1) vi(1,5:8) vi(1,5:6) vi(1,2:3) vi(1,7:8) vi(1,4)],...
        [vi(2,1:4) vi(2,1) vi(2,5:8) vi(2,5:6) vi(2,2:3) vi(2,7:8) vi(2,4)],...
        [vi(3,1:4) vi(3,1) vi(3,5:8) vi(3,5:6) vi(3,2:3) vi(3,7:8) vi(3,4)]);
    set(hbk0,'linestyle','--','color',[1 1 1]*.3)
    hbk1=line([vi(1,1:4) vi(1,1) vi(1,5:8) vi(1,5:6) vi(1,2:3) vi(1,7:8) vi(1,4)],...
        [vi(2,1:4) vi(2,1) vi(2,5:8) vi(2,5:6) vi(2,2:3) vi(2,7:8) vi(2,4)],...
        [vi(3,1:4) vi(3,1) vi(3,5:8) vi(3,5:6) vi(3,2:3) vi(3,7:8) vi(3,4)]);
    set(hbk1,'linewidth',2)
    hbk2=line([vi(1,1:4) vi(1,1)],...
        [vi(2,1:4) vi(2,1)],...
        [vi(3,1:4) vi(3,1)]);
    set(hbk2,'linewidth',2,'color','r')
    mx=max([lx ly lz])+1;
    brd=line([vi(1,1:4) vi(1,1) vi(1,5:8) vi(1,5:6) vi(1,2:3) vi(1,7:8) vi(1,4)]/lx*mx,...
        [vi(2,1:4) vi(2,1) vi(2,5:8) vi(2,5:6) vi(2,2:3) vi(2,7:8) vi(2,4)]/ly*mx,...
        [vi(3,1:4) vi(3,1) vi(3,5:8) vi(3,5:6) vi(3,2:3) vi(3,7:8) vi(3,4)]/lz*mx);
    set(brd,'linestyle',':','color',[1 1 1]*.7)
    
    exx=1; exy=0; exz=0;
    eyx=0; eyy=1; eyz=0;
    ezx=0; ezy=0; ezz=1;
    ex=line([0 exx],[0 exy],[0 exz]); set(ex,'color','r')
    ey=line([0 eyx],[0 eyy],[0 eyz]); set(ey,'color','b')
    ez=line([0 ezx],[0 ezy],[0 ezz]); set(ez,'color','g')
    tx=text(exx,exy,exz,'x');
    ty=text(eyx,eyy,eyz,'y');
    tz=text(ezx,ezy,ezz,'z');
    mxE=mx*.9;
    Ex=line([0 exx]-mxE,[0 exy]-mxE,[0 exz]-mxE); set(Ex,'color','r')
    Ey=line([0 eyx]-mxE,[0 eyy]-mxE,[0 eyz]-mxE); set(Ey,'color','b')
    Ez=line([0 ezx]-mxE,[0 ezy]-mxE,[0 ezz]-mxE); set(Ez,'color','g')
    Tx=text(exx-mxE,exy-mxE,exz-mxE,'X');
    Ty=text(eyx-mxE,eyy-mxE,eyz-mxE,'Y');
    Tz=text(ezx-mxE,ezy-mxE,ezz-mxE,'Z');
    axis([-1 1 -1 1 -1 1]*max([lx ly lz])), 
    axis equal,
    grid,

    for id=1:size(R,3)
        v=R(:,:,id)*vi;
        set(hbk1,'xdata',[v(1,1:4) v(1,1) v(1,5:8) v(1,5:6) v(1,2:3) v(1,7:8) v(1,4)],...
            'ydata',[v(2,1:4) v(2,1) v(2,5:8) v(2,5:6) v(2,2:3) v(2,7:8) v(2,4)],...
            'zdata',[v(3,1:4) v(3,1) v(3,5:8) v(3,5:6) v(3,2:3) v(3,7:8) v(3,4)])
        set(hbk2,'xdata',[v(1,1:4) v(1,1)],...
            'ydata',[v(2,1:4) v(2,1)],...
            'zdata',[v(3,1:4) v(3,1)])
        set(ex,'xdata',[0 R(1,1,id)],'ydata',[0 R(2,1,id)],'zdata',[0 R(3,1,id)])
        set(ey,'xdata',[0 R(1,2,id)],'ydata',[0 R(2,2,id)],'zdata',[0 R(3,2,id)])
        set(ez,'xdata',[0 R(1,3,id)],'ydata',[0 R(2,3,id)],'zdata',[0 R(3,3,id)])
        set(tx,'position',R(:,1,id))
        set(ty,'position',R(:,2,id))
        set(tz,'position',R(:,3,id))
        
        pause(0.01)
        
        if canRecord
            frame = getframe(gcf); % get frame
            writeVideo(myVideo, frame);
        end
    end
    
    if canRecord
        close(myVideo)
    end
end
