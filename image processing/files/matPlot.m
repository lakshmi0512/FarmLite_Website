function obj=matPlot(a, opt);

if nargin<1, selfdemo; return; end
if ischar(a) && strcmpi(a, 'defaultOpt')
	obj.matrixName='';
	obj.gridColor='k';
	obj.fontSize=10;
	obj.fontColor='a';
	obj.rowLabel=[];
	obj.colLabel=[];
	obj.highlightDiagonal=1;
	obj.showRowLeftLabel=1;
	obj.showRowRightLabel=1;
	obj.showColUpLabel=1;
	obj.showColDownLabel=1;
	obj.rowLeftLabel='';
	obj.rowRightLabel='';
	obj.colUpLabel='';
	obj.colDownLabel='';
	obj.format='11.4g';
	return
end
if nargin<2||isempty(opt), opt=feval(mfilename, 'defaultOpt'); end
if nargin<3, plotOpt=0; end


cla reset;
[m,n]=size(a);

if opt.highlightDiagonal
	for i=1:min(m, n);
		patch(i-1+[0 1 1 0 0], min(m,n)-i+[0 0 1 1 0], 'y');
	end
end
for i=1:m		% Index over number of rows
	for j=1:n	% Index over number of columns
		theStr=a(i,j);
		if isnumeric(a(i,j))
			theStr=num2str(a(i,j), ['%', opt.format]);
		end
		obj.element(i,j)=text(j-.5, m-i+.5, theStr, ...
			'HorizontalAlignment', 'center', ...
			'Color', 'b', ...
			'FontWeight', 'bold', ...
			'FontSize', opt.fontSize);
	end
end

for i=1:m
	if opt.showRowLeftLabel
		if isempty(opt.rowLeftLabel)
			for p=1:m, opt.rowLeftLabel{p}=int2str(p); end
		end
		obj.rowLeftLabel(i)=text(-0.1, m-i+.5, opt.rowLeftLabel{i}, ...
			'HorizontalAlignment', 'right', ...
			'Color', 'r', ...
			'FontWeight', 'bold', ...
			'FontSize', opt.fontSize);
	end
	if opt.showRowRightLabel
		if isempty(opt.rowRightLabel)
			if isnumeric(a)
				rowSum=sum(a, 2);
				for p=1:m, opt.rowRightLabel{p}=num2str(rowSum(p), ['%', opt.format]); end
			end
		end
		if ~isempty(opt.rowRightLabel)
			obj.rowRightLabel(i)=text(n+0.5, m-i+.5, opt.rowRightLabel{i}, ...
				'HorizontalAlignment', 'center', ...
				'Color', 'b', ...
				'FontWeight', 'bold', ...
				'FontSize', opt.fontSize);
		end
	end
end

for j=1:n
	if opt.showColUpLabel
		if isempty(opt.colUpLabel)
			for p=1:n, opt.colUpLabel{p}=int2str(p); end
		end
		obj.colUpLabel(j)=text(j-.5, m+.1, opt.colUpLabel{j}, ...
			'HorizontalAlignment', 'left', ...
			'rot', 90, ...
			'Color', 'r', ...
			'FontWeight', 'bold', ...
			'FontSize', opt.fontSize);
	end
	if opt.showColDownLabel
		if isempty(opt.colDownLabel)
			if isnumeric(a)
				colSum=sum(a, 1);
				for p=1:m, opt.colDownLabel{p}=num2str(colSum(p), ['%', opt.format]); end
			end
		end
		if ~isempty(opt.colDownLabel)
			obj.colDownLabel(j)=text(j-.5, -.2, opt.colDownLabel{j}, ...
				'HorizontalAlignment', 'center', ...
				'Color', 'b', ...
				'FontWeight', 'bold', ...
				'FontSize', opt.fontSize);
		end
	end
end

set(gca,'Box', 'on', ...
        'Visible', 'on', ...
        'xLim', [0 n], ...
        'xGrid', 'on', ...
        'xTickLabel', [], ...
        'xTick', 0:n, ...
        'yGrid', 'on', ...
        'yLim', [0 m], ...
        'yTickLabel', [], ...
        'yTick', 0:m, ...
        'DataAspectRatio', [1, 1, 1], ... 
        'GridLineStyle', ':', ...
        'LineWidth', 3, ...
        'XColor', opt.gridColor, ...
        'YColor', opt.gridColor);

xlabel(opt.matrixName);
set(get(gca, 'xlabel'), 'position', [n/2, -1])
set(gcf, 'numbertitle', 'off', 'name', opt.matrixName);

function selfdemo
mObj=mFileParse(which(mfilename));
strEval(mObj.example);
