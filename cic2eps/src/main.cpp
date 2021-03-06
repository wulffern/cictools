//====================================================================
//        Copyright (c) 2015 Carsten Wulff Software, Norway
// ===================================================================
// Created       : wulff at 2015-4-19
// ===================================================================
//   This program is free software: you can redistribute it and/or modify
//   it under the terms of the GNU General Public License as published by
//   the Free Software Foundation, either version 3 of the License, or
//   (at your option) any later version.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.
//
//   You should have received a copy of the GNU General Public License
//   along with this program.  If not, see <http://www.gnu.org/licenses/>.
//====================================================================


#include "cic-core.h"
#include "cic-graphics.h"
#include <iostream>
#include <QDebug>
#include <QString>

int main(int argc, char *argv[])
{

    try
    {

        if(argc >=  3){

            QString file = argv[1];
            QString rules = argv[2];
            QString cell = argv[3];

            if(cell == ""){
                QRegularExpression re("/?([^\\/]+)\\.json");
                QRegularExpressionMatch m = re.match(file);
                cell = m.captured(1);
            }

            //Load rules
            cIcCore::Rules::loadRules(rules);

            //Load design, this is where the magic happens
            cIcCore::Design * d= new cIcCore::Design();
            d->readJsonFile(file);


            cIcPrinter::Eps * eps = new cIcPrinter::Eps(cell);
            eps->print(d,cell);

        }else{
            qWarning() << "Usage: cic2eps <CIC file> <Technology file> <Cell>";
        }

    }catch(...){

        return -1;
    }





}
