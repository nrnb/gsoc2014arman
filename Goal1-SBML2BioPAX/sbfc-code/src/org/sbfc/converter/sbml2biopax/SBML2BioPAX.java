/*
 *
 * ==============================================================================
 * Copyright (c) 2010-2014 the copyright is held jointly by the individual
 * authors. See the file AUTHORS for the list of authors
 *
 * This file is part of The System Biology Format Converter (SBFC).
 *
 * SBFC is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * SBFC is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with SBFC.  If not, see<http://www.gnu.org/licenses/>.
 * 
 * ==============================================================================
 * 
 */

package org.sbfc.converter.sbml2biopax;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.biopax.paxtools.model.BioPAXLevel;
import org.biopax.paxtools.model.Model;
import org.sbfc.converter.GeneralConverter;
import org.sbfc.converter.models.BioPaxModel;
import org.sbfc.converter.models.GeneralModel;

import java.util.logging.Logger;

/**
 * Convert an SBML file into a BioPax owl file.
 * 
 * The package uk.ac.ebi.compneur.sbmlannotation is not used at the moment !!! Work in progress from Arnaud :-)
 * 
 * @author Arnaud Henry
 * @author Nicolas Rodriguez
 * @author Camille Laibe
 * @author B. Arman Aksoy < arman _ cbio.mskcc.org >
 * 
 * @version 2.3
 * 
 */

public class SBML2BioPAX extends GeneralConverter {
    private static Log log = LogFactory.getLog(SBML2BioPAX.class);

    public SBML2BioPAX() {
        super();
	}

    @Override
    public GeneralModel convert(GeneralModel model) {
        Model bpModel = BioPAXLevel.L3.getDefaultFactory().createModel();
        BioPaxModel bioPaxModel = new BioPaxModel(bpModel);

        System.out.println("Hullo there!");

        return bioPaxModel;
    }

    @Override
    public String getResultExtension() {
        return ".owl";
    }
}
