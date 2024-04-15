/***************************************************************************
 * Copyright (C) gempa GmbH                                                *
 * All rights reserved.                                                    *
 * Contact: gempa GmbH (seiscomp-dev@gempa.de)                             *
 *                                                                         *
 * GNU Affero General Public License Usage                                 *
 * This file may be used under the terms of the GNU Affero                 *
 * Public License version 3.0 as published by the Free Software Foundation *
 * and appearing in the file LICENSE included in the packaging of this     *
 * file. Please review the following information to ensure the GNU Affero  *
 * Public License version 3.0 requirements will be met:                    *
 * https://www.gnu.org/licenses/agpl-3.0.html.                             *
 *                                                                         *
 * Other Usage                                                             *
 * Alternatively, this file may be used in accordance with the terms and   *
 * conditions contained in a signed written agreement between you and      *
 * gempa GmbH.                                                             *
 ***************************************************************************/

%feature("ref")   Seiscomp::Core::BaseObject "if ($this) $this->incrementReferenceCount();"
%feature("unref") Seiscomp::Core::BaseObject "if ($this) $this->decrementReferenceCount();"

%rename(Unset) Seiscomp::Core::None;
%ignore *::operator=;
%ignore *::operator++;
%ignore *::operator[];

%newobject Seiscomp::Core::MetaProperty::createClass;
%newobject Seiscomp::Core::MetaProperty::arrayObject;

%include "seiscomp/core.h"
%import "seiscomp/core/factory.h"
%include stdint.i
%include std_string.i
%include std_complex.i
%include "seiscomp/core/archive.h"
%include "seiscomp/core/io.h"
%include "seiscomp/core/rtti.h"
%include "seiscomp/core/metaobject.h"
%include "seiscomp/core/defs.h"

%apply int *OUTPUT { int *year, int *month, int *day,
                     int *hour, int *min, int *sec,
                     int *usec };

%apply int *OUTPUT { int *year, int *yday,
                     int *hour, int *min, int *sec,
                     int *usec };

%include "seiscomp/core/optional.h"
%include "seiscomp/core/enumeration.h"
%include "seiscomp/core/exceptions.h"


%exception {
  try {
    $action
  }
  catch ( const Seiscomp::Core::ValueException &e) {
    SWIG_exception(SWIG_ValueError, e.what());
  }
  catch ( const std::exception &e) {
    SWIG_exception(SWIG_RuntimeError, e.what());
  }
  catch ( ... ) {
    SWIG_exception(SWIG_UnknownError, "C++ anonymous exception");
  }
}


%include "seiscomp/core/baseobject.h"
%include "seiscomp/core/interruptible.h"
%include "seiscomp/core/version.h"

/* Optional<bool> typemaps */
%typemap(in) const Seiscomp::Core::Optional<bool>::Impl& (Seiscomp::Core::Optional<bool>::Impl tmp) {
  if ( $input != Py_None ) {
    if ( !PyBool_Check($input) ) {
      SWIG_exception(SWIG_TypeError, "a 'bool' is expected");
      SWIG_fail;
    }
    int v = PyInt_AsLong($input);
    tmp = Seiscomp::Core::Optional<bool>::Impl(static_cast<bool>(v));
  }
  $1 = &tmp;
}

%typemap(out) const Seiscomp::Core::Optional<bool>::Impl& {
  if ( *$1 == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    $result = **$1;
  }
}

%typemap(out) Seiscomp::Core::Optional<bool>::Impl {
  if ( *(&$1) == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    $result = **(&$1);
  }
}

%typemap(typecheck) Seiscomp::Core::Optional<bool>::Impl {
  $1 = $input == Py_None || PyBool_Check($input) ? 1 : 0;
}

%typemap(typecheck) const Seiscomp::Core::Optional<bool>::Impl& = Seiscomp::Core::Optional<bool>::Impl;


/* Optional<int> typemaps */
%typemap(in) const Seiscomp::Core::Optional<int>::Impl& (Seiscomp::Core::Optional<int>::Impl tmp) {
  if ( $input != Py_None ) {
    if ( !PyFloat_Check($input) &&
         !PyInt_Check($input) &&
         !PyLong_Check($input) ) {
      SWIG_exception(SWIG_TypeError, "a 'integer' is expected");
      SWIG_fail;
    }
    long v = PyInt_AsLong($input);
    tmp = Seiscomp::Core::Optional<int>::Impl(static_cast<int>(v));
  }
  $1 = &tmp;
}

%typemap(out) const Seiscomp::Core::Optional<int>::Impl& {
  if ( *$1 == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    int v = **$1;
    $result = PyInt_FromLong(static_cast<long>(v));
  }
}

%typemap(out) Seiscomp::Core::Optional<int>::Impl {
  if ( *(&$1) == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    int v = **(&$1);
    $result = PyInt_FromLong(static_cast<long>(v));
  }
}

%typemap(typecheck) Seiscomp::Core::Optional<int>::Impl {
  $1 = $input == Py_None ||
       PyFloat_Check($input) ||
       PyInt_Check($input) ||
       PyLong_Check($input) ? 1 : 0;
}

%typemap(typecheck) const Seiscomp::Core::Optional<int>::Impl& = Seiscomp::Core::Optional<int>::Impl;


/* Optional<double> typemaps */
%typemap(in) const Seiscomp::Core::Optional<double>::Impl& (Seiscomp::Core::Optional<double>::Impl tmp) {
  if ( $input != Py_None ) {
    if ( !PyFloat_Check($input) &&
         !PyInt_Check($input) &&
         !PyLong_Check($input) ) {
      SWIG_exception(SWIG_TypeError, "a 'float' is expected");
      SWIG_fail;
    }
    double v = PyFloat_AsDouble($input);
    tmp = Seiscomp::Core::Optional<double>::Impl(static_cast<double>(v));
  }
  $1 = &tmp;
}

%typemap(out) const Seiscomp::Core::Optional<double>::Impl& {
  if ( *$1 == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    double v = **$1;
    $result = PyFloat_FromDouble(static_cast<double>(v));
  }
}

%typemap(out) Seiscomp::Core::Optional<double>::Impl {
  if ( *(&$1) == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    double v = **(&$1);
    $result = PyFloat_FromDouble(static_cast<double>(v));
  }
}

%typemap(typecheck) Seiscomp::Core::Optional<double>::Impl {
  $1 = $input == Py_None ||
       PyFloat_Check($input) ||
       PyInt_Check($input) ||
       PyLong_Check($input) ? 1 : 0;
}

%typemap(typecheck) const Seiscomp::Core::Optional<double>::Impl& = Seiscomp::Core::Optional<double>::Impl;


/* Optional<ClassType> typemaps */
%define optional(_class)

%typemap(in) const Seiscomp::Core::Optional<_class>::Impl& (Seiscomp::Core::Optional<_class>::Impl tmp) {
  if ( $input != Py_None ) {
    _class* value;
    if ( SWIG_ConvertPtr($input, (void **) &value, $descriptor(_class*), SWIG_POINTER_EXCEPTION | 0) == -1 ) {
         SWIG_fail;
    }
    tmp = *value;
  }

  $1 = &tmp;
}

%typemap(in) Seiscomp::Core::Optional<_class>::Impl (Seiscomp::Core::Optional<_class>::Impl tmp) {
  if ( $input != Py_None ) {
    _class* value;
    if ( SWIG_ConvertPtr($input, (void **) &value, $descriptor(_class*), SWIG_POINTER_EXCEPTION | 0) == -1 ) {
         SWIG_fail;
    }
    tmp = *value;
  }

  $1 = &tmp;
}

/*%typemap(in) Seiscomp::Core::Optional<_class>::Impl = const Seiscomp::Core::Optional<_class>::Impl&;*/

%typemap(out) const Seiscomp::Core::Optional<_class>::Impl& {
  if ( *$1 == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    _class* resulttime = new _class(**$1);
    $result = SWIG_NewPointerObj(resulttime, $descriptor(_class*), 1);
  }
}

%typemap(out) Seiscomp::Core::Optional<_class>::Impl {
  if ( *(&$1) == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    _class* resulttime = new _class(**(&$1));
    $result = SWIG_NewPointerObj(resulttime, $descriptor(_class*), 1);
  }
}

%typemap(typecheck) const Seiscomp::Core::Optional<_class>::Impl& {
   if ( $input == Py_None )
     $1 = 1;
   else {
     void* ptr = 0;
     $1 = SWIG_ConvertPtr($input, (void**)&ptr, $descriptor(_class*), 0) == -1 ? 0 : 1;
   }
}

%typemap(typecheck) Seiscomp::Core::Optional<_class>::Impl {
   if ( $input == Py_None )
     $1 = 1;
   else {
     void* ptr = 0;
     $1 = SWIG_ConvertPtr($input, (void**)&ptr, $descriptor(_class*), 0) == -1 ? 0 : 1;
   }
}

/*%typemap(typecheck) Seiscomp::Core::Optional<_class>::Impl = const Seiscomp::Core::Optional<_class>::Impl&;*/

%enddef


/* Enum<Name, ...> typemaps */
%define enum(_class)

%typemap(in) _class (_class::Type tmp) {
  tmp = (_class::Type)PyInt_AsLong($input);
  if ( tmp < _class::First || tmp > _class::End ) {
    SWIG_exception(SWIG_ValueError, "enum value out of range");
    SWIG_fail;
  }
  $1 = tmp;
}

%typemap(out) _class {
  _class tmp = $1;
  $result = PyInt_FromLong(static_cast<long>((_class::Type)tmp.toInt()));
}

%typemap(typecheck) _class = int;

%ignore _class;

%enddef

/* Optional Enum<Name, ...> typemaps */
%define optional_enum(_class)

%typemap(in) const Seiscomp::Core::Optional<_class>::Impl& (Seiscomp::Core::Optional<_class>::Impl tmp) {
  if ( $input != Py_None ) {
    _class::Type value = (_class::Type)PyInt_AsLong($input);
    if ( value < _class::First || value > _class::End ) {
      SWIG_exception(SWIG_ValueError, "enum value out of range");
      SWIG_fail;
    }

    tmp = value;
  }

  $1 = &tmp;
}

%typemap(in) Seiscomp::Core::Optional<_class>::Impl (Seiscomp::Core::Optional<_class>::Impl tmp) {
  if ( $input != Py_None ) {
    _class::Type value = (_class::Type)PyInt_AsLong($input);
    if ( value < _class::First || value > _class::End ) {
      SWIG_exception(SWIG_ValueError, "enum value out of range");
      SWIG_fail;
    }

    tmp = value;
  }

  $1 = &tmp;
}

/* %typemap(in) Seiscomp::Core::Optional<_class>::Impl = const Seiscomp::Core::Optional<_class>::Impl&; */

%typemap(out) const Seiscomp::Core::Optional<_class>::Impl& {
  if ( *(&$1) == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    _class tmp = **(&$1);
    $result = PyInt_FromLong(static_cast<long>((_class::Type)tmp));
  }
}

%typemap(out) Seiscomp::Core::Optional<_class>::Impl {
  if ( *(&$1) == Seiscomp::Core::None ) {
    $result = Py_None;
  }
  else {
    _class tmp = **(&$1);
    $result = PyInt_FromLong(static_cast<long>((_class::Type)tmp));
  }
}

%ignore _class;

%enddef


optional(Seiscomp::Core::Time);


%include "seiscomp/core/datetime.h"
%template(GenericArchive) Seiscomp::Core::Generic::Archive<Seiscomp::Core::BaseObject>;

%newobject Seiscomp::Core::Generic::Archive<Seiscomp::Core::BaseObject>::readObject;

%extend Seiscomp::Core::Generic::Archive<Seiscomp::Core::BaseObject> {
  Seiscomp::Core::BaseObject *readObject() {
    Seiscomp::Core::BaseObject* obj;
    *self >> obj;
    return obj;
  }

  void writeObject(Seiscomp::Core::BaseObject* obj) {
    *self << obj;
  }
};

%apply const Seiscomp::Core::Optional<double>::Impl& {
	const Seiscomp::Core::Optional<float>::Impl&
};

%apply Seiscomp::Core::Optional<double>::Impl {
	Seiscomp::Core::Optional<float>::Impl
};

%ignore Seiscomp::Core::None;


%extend Seiscomp::Core::TimeSpan {
  double toDouble() const {
    return (double)(*self);
  }
};

%extend Seiscomp::Core::GeneralException {
        %pythoncode %{
                def __str__(self):
                        return self.what()
        %}
};
