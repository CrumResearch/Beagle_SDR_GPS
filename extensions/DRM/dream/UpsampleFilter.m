%******************************************************************************\
%*
%* Copyright (c) 2001-2014
%*
%* Author:
%*	David Flamand
%*
%* Description:
%* 	Lowpass Filter for Upsampling
%*
%******************************************************************************
%*
%* This program is free software; you can redistribute it and/or modify it under
%* the terms of the GNU General Public License as published by the Free Software
%* Foundation; either version 2 of the License, or (at your option) any later 
%* version.
%*
%* This program is distributed in the hope that it will be useful, but WITHOUT 
%* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
%* FOR A PARTICULAR PURPOSE. See the GNU General Public License for more 
%* details.
%*
%* You should have received a copy of the GNU General Public License along with
%* this program; if not, write to the Free Software Foundation, Inc., 
%* 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
%*
%******************************************************************************/

n = 303;
ripple_dB = 0.05;
att_dB = 100;

f = [0 (1/2-1/32) (1/2) 1];
m = [1 1 0 0];
w = [(1/(1 - 10 ^ (-ripple_dB / 20))) (1/(10 ^ (-att_dB / 20)))];
b = remez(n - 1, f, m, w, 'bandpass');

PLOT = 1;
if (PLOT == 1)
    close all;
    freqz(b);
    plot(b);
    figure;
end

fid = fopen('UpsampleFilter.h', 'w');
fprintf(fid, '/* Automatically generated file with GNU Octave */\n');
fprintf(fid, '\n');
fprintf(fid, '/* File name: "UpsampleFilter.m" */\n');
fprintf(fid, '/* Filter taps in time-domain */\n');
fprintf(fid, '\n');
fprintf(fid, '#ifndef _UPSAMPLEFILTER_H_\n');
fprintf(fid, '#define _UPSAMPLEFILTER_H_\n');
fprintf(fid, '\n');
fprintf(fid, '#define NUM_TAPS_UPSAMPLE_FILT %i\n', n);
fprintf(fid, '\n');
fprintf(fid, 'static const double dUpsampleFilt[NUM_TAPS_UPSAMPLE_FILT] =\n');
fprintf(fid, '{\n');
fprintf(fid, '	%.18e,\n', b(1:end - 1));
fprintf(fid, '	%.18e\n', b(end));
fprintf(fid, '};\n');
fprintf(fid, '\n');
fprintf(fid, '#endif /* _UPSAMPLEFILTER_H_ */\n');
fclose(fid);

if (PLOT == 1)
    input("press enter to exit ");
end
