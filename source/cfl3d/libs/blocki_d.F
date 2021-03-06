c  ---------------------------------------------------------------------------
c  CFL3D is a structured-grid, cell-centered, upwind-biased, Reynolds-averaged
c  Navier-Stokes (RANS) code. It can be run in parallel on multiple grid zones
c  with point-matched, patched, overset, or embedded connectivities. Both
c  multigrid and mesh sequencing are available in time-accurate or
c  steady-state modes.
c
c  Copyright 2001 United States Government as represented by the Administrator
c  of the National Aeronautics and Space Administration. All Rights Reserved.
c 
c  The CFL3D platform is licensed under the Apache License, Version 2.0 
c  (the "License"); you may not use this file except in compliance with the 
c  License. You may obtain a copy of the License at 
c  http://www.apache.org/licenses/LICENSE-2.0. 
c 
c  Unless required by applicable law or agreed to in writing, software 
c  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT 
c  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the 
c  License for the specific language governing permissions and limitations 
c  under the License.
c  ---------------------------------------------------------------------------
c
      subroutine blocki_d (q,qi0,idimr,jdimr,kdimr,jdimt,kdimt,limblk,
     .                     isva,it,ir,nvals,ldim,bci,iedge)
c
c     $Id$
c
c***********************************************************************
c      Purpose: Transfer information from block (ir) to qi0 array of
c      block (it).
c***********************************************************************
c
#   ifdef CMPLX
      implicit complex(a-h,o-z)
#   endif
c
      dimension limblk(2,6),isva(2,2)
      dimension qi0(jdimt,kdimt,ldim,2), q(nvals,ldim,2)
      dimension bci(jdimt,kdimt,2)
c
      jst = limblk(it,2)
      jet = limblk(it,5)
      if (jst .eq. jet) then
         jinct = 1
      else
         jinct = (jet-jst)/abs(jet-jst)
      end if
c
      kst = limblk(it,3)
      ket = limblk(it,6)
      if (kst .eq. ket) then
         kinct = 1
      else
         kinct = (ket-kst)/abs(ket-kst)
      end if
c
c     determine the side of the q array to transfer from
c
c     k = constant side
c
      if (isva(ir,1)+isva(ir,2) .eq. 3) then
         if ((isva(ir,1) .eq. isva(it,1)) .or. 
     .       (isva(ir,2) .eq. isva(it,2))) then
c
c     i varies with k     and     j varies with j
c
            ij = 0
            do 200 k=kst,ket,kinct
               do 100 j=jst,jet,jinct
                  ij = ij + 1
                  do 50 l = 1,ldim
                     qi0(j,k,l,1) = q(ij,l,1)
                     qi0(j,k,l,2) = q(ij,l,2)
                     bci(j,k,iedge) = 0.0
   50             continue
  100          continue
  200       continue
         else
c
c     j varies with k     and     i varies with j
c
            ij = 0
            do 500 k=kst,ket,kinct
               do 400 j=jst,jet,jinct
                  ij = ij + 1
                  do 350 l = 1,ldim
                     qi0(j,k,l,1) = q(ij,l,1)
                     qi0(j,k,l,2) = q(ij,l,2)
                     bci(j,k,iedge) = 0.0
  350             continue
  400          continue
  500       continue
         end if
c  
c     j = constant side
c
      else if (isva(ir,1)+isva(ir,2) .eq. 4) then
c
         if ((isva(ir,1) .eq. isva(it,1)) .or. 
     .       (isva(ir,2) .eq. isva(it,2))) then
c
c     i varies with j    and    k varies with k
c
            ij = 0
            do 800 k=kst,ket,kinct
               do 700 j=jst,jet,jinct
                  ij = ij + 1
                  do 650 l = 1,ldim
                     qi0(j,k,l,1) = q(ij,l,1)
                     qi0(j,k,l,2) = q(ij,l,2)
                     bci(j,k,iedge) = 0.0
  650             continue
  700          continue
  800       continue
         else
c
c     i varies with k    and    k varies with j
c
            ij = 0
            do 1100 k=kst,ket,kinct
               do 1000 j=jst,jet,jinct
                  ij = ij + 1
                  do 950 l = 1,ldim
                     qi0(j,k,l,1) = q(ij,l,1)
                     qi0(j,k,l,2) = q(ij,l,2)
                     bci(j,k,iedge) = 0.0
  950             continue
 1000          continue
 1100       continue
         end if
c 
c     i = constant side
c
      else if (isva(ir,1)+isva(ir,2) .eq. 5) then
c
         if ((isva(ir,1) .eq. isva(it,1)) .or. 
     .       (isva(ir,2) .eq. isva(it,2))) then
c
c     k varies with k    and    j varies with j
c
            ij = 0
            do 1400 k=kst,ket,kinct
               do 1300 j=jst,jet,jinct
                  ij = ij + 1
                  do 1250 l = 1,ldim
                     qi0(j,k,l,1) = q(ij,l,1)
                     qi0(j,k,l,2) = q(ij,l,2)
                     bci(j,k,iedge) = 0.0
 1250             continue
 1300          continue
 1400       continue
         else
c
c     j varies with k    and    k varies with j
c
            ij = 0
            do 1700 k=kst,ket,kinct
               do 1600 j=jst,jet,jinct
                  ij = ij + 1
                  do 1550 l = 1,ldim
                     qi0(j,k,l,1) = q(ij,l,1)
                     qi0(j,k,l,2) = q(ij,l,2)
                     bci(j,k,iedge) = 0.0
 1550             continue
 1600          continue
 1700       continue
         end if
      end if
c
      return
      end
