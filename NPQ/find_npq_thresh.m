function [thresholds, hp_scores] = find_npq_thresh(RunObj,NIND,MAXGEN)

GGAP = .9;           % Generation gap, how many new individuals are created
PRECI = 32;          % Precision of binary representation

XX_disc=RunObj.data.projData;

thresholds=zeros(size(RunObj.XX,2),15);
thresholds(thresholds==0)=-Inf;

fn = @get_thresh_f1_ga;

hp_scores=[];
    
for d=1:size(XX_disc,2)
    
    XX_disc_temp=XX_disc(1:RunObj.num_affin,:);
    num_points=size(XX_disc_temp,1);
    
    [XX_disc_temp,XX_ind]=sort(XX_disc_temp,1,'ascend');
    
    connectivity=RunObj.Straining;
    connectivity=connectivity(1:RunObj.num_affin,1:RunObj.num_affin);
    
    num_bits=bits_per_dim;
    
    [i,j,v]=find(connectivity);
    total_num_true_pairs=sum(v);
    
    if(num_bits==2)
        % Build field descriptor
        FieldD = [rep([PRECI],[1, 3]); rep([1;RunObj.num_affin],[1, 3]);...
            rep([0; 0; 0 ;0], [1, 3])];
        NVAR=3;
    elseif(num_bits==3)
        FieldD = [rep([PRECI],[1, 7]); rep([1;RunObj.num_affin],[1, 7]);...
            rep([0; 0; 0 ;0], [1, 7])];
        NVAR=7;
    elseif(num_bits==4)
        FieldD = [rep([PRECI],[1, 15]); rep([1;RunObj.num_affin],[1, 15]);...
            rep([0; 0; 0 ;0], [1, 15])];
        NVAR=15;
    end
    
    XX_dim=XX_ind(:,d);
    XX_disc_dim=XX_disc_temp(:,d);
    
    % Initialise population
    Chrom = crtbp(NIND, NVAR*PRECI);
    
    % Reset counters
    Best = NaN*ones(MAXGEN,1);	% best in current population
    gen = 0;			% generational counter
    
    % Evaluate initial population
    
    [RunObjV] = fn(XX_dim, XX_disc_dim, num_points, connectivity,  RunObj.ALPHA, RunObj.BETA, bs2rv(Chrom,FieldD));
    
    % Track best individual and display convergence
    %     Best(gen+1) = min(RunObjV);
    %     plot(log10(Best),'ro');xlabel('generation'); ylabel('log10(f(x))');
    %     text(0.5,0.95,['Best = ', num2str(Best(gen+1))],'Units','normalized');
    %     drawnow;
    %
    % Generational loop
    
    while gen < MAXGEN,
        
        % Assign fitness-value to entire population
        FitnV = ranking(RunObjV);
        
        % Select individuals for breeding
        SelCh = select('sus', Chrom, FitnV, GGAP);
        
        % Recombine selected individuals (crossover)
        SelCh = recombin('xovsp',SelCh,0.7);
        
        % Perform mutation on offspring
        SelCh = mut(SelCh);
        
        % Evaluate offspring, call RunObjective function
        [RunObjVSel] = fn(XX_dim, XX_disc_dim, num_points, connectivity, RunObj.ALPHA, RunObj.BETA, bs2rv(SelCh,FieldD));
        
        % Reinsert offspring into current population
        [Chrom RunObjV]=reins(Chrom,SelCh,1,1,RunObjV,RunObjVSel);
        
        % Increment generational counter
        gen = gen+1;
    end
    % End of GA
    
    [low,ind]=min(RunObjV);
    res=bs2rv(Chrom,FieldD);
    thresh=sort(res(ind,:),2,'ascend');
    
    thresh_temp=[0,thresh,num_points];
    
    hp_scores(d,:)=1-low;
    
    i=1;
    while i < size(thresh_temp,2)
        
        if (int32(thresh_temp(:,i))+1) > int32(thresh_temp(:,i+1))
            cluster1_max=int32(thresh_temp(:,i+1));
        else
            cluster1_max=(int32(thresh_temp(:,i))+1):int32(thresh_temp(:,i+1));
        end
        
        if (int32(thresh_temp(:,i+1))+1) > int32(thresh_temp(:,i+2))
            cluster2_max=int32(thresh_temp(:,i+2));
        else
            cluster2_max=(int32(thresh_temp(:,i+1))+1):int32(thresh_temp(:,i+2));
        end
        
        centroid1=mean(XX_disc_dim(cluster1_max,:));
        centroid2=mean(XX_disc_dim(cluster2_max,:));
        
        thresholds(d,i)=(centroid2+centroid1)/2;
        
        if (i+2) >= size(thresh_temp,2)
            break;
        end
        
        i=i+1;
    end
    
end
thresholds=sort(thresholds,2,'ascend');


