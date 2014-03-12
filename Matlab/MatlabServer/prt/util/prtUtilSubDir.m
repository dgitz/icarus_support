function List = prtUtilSubDir(directory,match,dirMatch,recurse, ignoreDotFiles)
% xxx Need Help xxx
% List = prtUtilSubDir(directory,match)

% Copyright (c) 2013 New Folder Consulting
%
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
%
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE.

if nargin < 2 || isempty(match)
    match = '*';
end

if nargin < 3 || isempty(dirMatch)
    dirMatch = '*';
end

if nargin < 4 || isempty(recurse)
    recurse = true;
end

if nargin < 5 || isempty(ignoreDotFiles)
    ignoreDotFiles = false;
end


X = dir(fullfile(directory,dirMatch));

Xdir = X(cat(1,X.isdir));

Xdir = Xdir(~cellfun(@(x)ismember(x,{'.';'..'}),{Xdir.name}));

DC = dir(fullfile(directory,match));
DC = DC(~cat(1,DC.isdir));

if ignoreDotFiles
    DC = DC(cellfun(@(c)c(1)~='.',{DC.name}));
end

List = {};
if recurse
    for ind = 1:length(Xdir)
        NewDir = fullfile(directory,Xdir(ind).name);
        cList = prtUtilSubDir(NewDir,match,dirMatch);
        List = [List;cList];
    end
end
List = [List;cellfun(@(x)fullfile(directory,x),{DC.name}','uniformoutput',false)];
