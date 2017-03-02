%
%           findparents for k-Omega
%           K-Omega - Emad Hasan
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function potcl=findparents(ct,c)


if isempty(ct)==1  %If empty ct, return to main
    potcl=[];
else




 % Find which branch ct belongs to   
    [cr,cl]=size(c);
    chfi=[];
    for crr=1:cr
        for cll=1:cl
            [w,l]=size(c{crr,cll});
            for lll=1:l
                if isempty(c{crr,cll}(:,lll))==0
                    if (c{crr,cll}(:,lll)==ct)
                        chfi=[crr cll];

                    end
                end
                if ~isempty(chfi)
                    break
                end
            end
            if ~isempty(chfi)
                break
            end
        end
        if ~isempty(chfi)
            break
        end
    end
    
    if ~isempty(chfi)


        % Find the parents of ct
        cr=chfi(1);
        node=ct(2);
        potcl=[];

        for n=1:cr
            if (cr-n)<=1
                break
            end
            candcl=cat(2,c{(cr-n),:});
            curind=find(candcl(1,:)==node);
            if isempty(curind==0)
                potcl=[];
                break
            end
            [j,k]=size(potcl);
            %[r,l]=size(candcl(:,curind));
            x=sort(candcl(:,curind),2);
            potcl(:,k+1)=x(:,1);
            node=x(2,1);
        end

    else
        potcl=[];
    end







end

return;
