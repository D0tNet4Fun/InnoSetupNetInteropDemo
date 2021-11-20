using System.Runtime.InteropServices;

namespace NetDll
{
    public class DllMain
    {
        [DllExport(CallingConvention.StdCall)]
        public static void UpdateInt(ref int input)
        {
            input++;
        }

        [DllExport(CallingConvention.StdCall)]
        public static void UpdateString([MarshalAs(UnmanagedType.BStr)] ref string value)
        {
            value += " (updated)";
        }
    }
}