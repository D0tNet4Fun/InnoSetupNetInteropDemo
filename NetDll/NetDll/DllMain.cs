using System;
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

        [DllExport(CallingConvention.StdCall)]
        public static void GetComplexType(out ComplexType value)
        {
            value = new ComplexType
            {
                StringValue = "new",
                IntValue = 1
            };
        }

        [DllExport(CallingConvention.StdCall)]
        public static void GetComplexTypeArray(out int length, out ComplexType[] array)
        {
            array = new[]
            {
                new ComplexType
                {
                    StringValue = "Item 1",
                    IntValue = 1,
                },
                new ComplexType
                {
                    StringValue = "Item 2",
                    IntValue = 2
                }
            };
            length = array.Length;
        }

        [UnmanagedFunctionPointer(CallingConvention.StdCall)]
        public delegate void ProcWithComplexTypeArg(ref ComplexType value);

        [DllExport(CallingConvention.StdCall)]
        public static void CallProcedure([MarshalAs(UnmanagedType.FunctionPtr)] ProcWithComplexTypeArg callback)
        {
            var complexType = new ComplexType
            {
                StringValue = "callback",
                IntValue = 30
            };
            callback(ref complexType);
        }
    }
}