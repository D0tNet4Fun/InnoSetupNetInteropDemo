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

        [DllExport(CallingConvention.StdCall)]
        public static void UpdateComplexType(ref ComplexType value)
        {
            value.StringValue += " (updated)";
            value.IntValue++;
        }

        [DllExport(CallingConvention.StdCall)]
        public static void UpdateComplexTypeReference(ref ComplexType value)
        {
            value = new ComplexType
            {
                StringValue = "changed",
                IntValue = 40
            };
        }
    }
}