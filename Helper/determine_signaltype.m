## Copyright (C) 2019 David Gitz
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} determine_signaltype (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: David Gitz <robot@dgitzdev>
## Created: 2019-08-04

function [retval,retval_string,data_structure,signalname] = determine_signaltype (filename)
global SIGNALTYPES;
data_structure = [];
signalname = 'Unknown';
if(isempty(strfind(filename,'resource.csv')) == 0)
  retval = SIGNALTYPES.RESOURCE;
  retval_string = 'Resource';
  signalname = filename(1:end-13)
  data_structure(1).name = 'PID';
  data_structure(1).column = 5;
  data_structure(1).datatype = 'int';
  data_structure(2).name = 'RAM_MB';
  data_structure(2).column = 6;
  data_structure(2).datatype = 'int';
  data_structure(3).name = 'CPU_Perc';
  data_structure(3).column = 7;
  data_structure(3).datatype = 'int';
elseif(isempty(strfind(filename,'resource_available.csv')) == 0)
  retval = SIGNALTYPES.RESOURCE_AVAILABLE;
  retval_string = 'Resource Available';
  signalname = filename(1:end-23);
  data_structure(1).name = 'RAM_MB';
  data_structure(1).column = 6;
  data_structure(1).datatype = 'int';
  data_structure(2).name = 'CPU_Perc';
  data_structure(2).column = 7;
  data_structure(2).datatype = 'int';
else
  retval = SIGNALTYPES.UNKNOWN;
  retval_string = 'Unknown';
end
endfunction
