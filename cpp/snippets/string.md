# String Snippets

## Convertions between MString and QString

Use MQtUtil::toQString and MQtUtil::toMString (OpenMayaUI)

```cpp

#include <maya/MQtUtil.h>

QString q_string = "I'm Qt String";
MString m_string = "I'm Maya String";

QString converted_from_mstring = MQtUtil::toQString(m_string);
MString converted_from_qstring = MQtUtil::toMString(q_string);

```