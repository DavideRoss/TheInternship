// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MonitorBlu_Shader"
{
	Properties
	{
		_Map("Map", 2D) = "white" {}
		_Offset("Offset", Vector) = (0,0,0,0)
		_Tiling("Tiling", Vector) = (0,0,0,0)
		_Float0("Float 0", Float) = 10
		_Remap("Remap", Vector) = (0,0,0,0)
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Map;
		uniform float _Float0;
		uniform sampler2D _TextureSample1;
		uniform float2 _Tiling;
		uniform float2 _Offset;
		uniform float4 _Remap;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 smoothstepResult229 = smoothstep( float4( 0,0,0,0 ) , float4( 1,1,1,0 ) , tex2D( _Map, i.uv_texcoord ));
			float clampResult77 = clamp( ( _SinTime.w * _Float0 ) , 0.8 , 1.0 );
			float4 clampResult244 = clamp( ( smoothstepResult229 * clampResult77 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float2 uv_TexCoord19 = i.uv_texcoord * _Tiling + ( _Offset * _Time.y );
			float4 temp_cast_0 = (_Remap.x).xxxx;
			float4 temp_cast_1 = (_Remap.y).xxxx;
			float4 temp_cast_2 = (_Remap.z).xxxx;
			float4 temp_cast_3 = (_Remap.w).xxxx;
			float4 lerpResult247 = lerp( float4( 0,0,0,0 ) , clampResult244 , (temp_cast_2 + (tex2D( _TextureSample1, uv_TexCoord19 ) - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0)));
			o.Emission = lerpResult247.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-1906;5;815;1011;-1294.028;-213.3255;1.786506;False;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;218;1174.4,435.2;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;223;1376,880;Float;False;Property;_Float0;Float 0;10;0;Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;76;1392,720;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;220;992,1248;Float;False;Property;_Offset;Offset;8;0;Create;True;0;0;False;0;0,0;0,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TimeNode;15;944,1376;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;1488.9,409;Float;True;Property;_Map;Map;0;0;Create;True;0;0;False;0;73e073da55a31ce4bb4eb1b4368a0d76;83023a1a0d54d8c459b81c48332b0e91;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;226;1162.8,1140.7;Float;False;Property;_Tiling;Tiling;9;0;Create;True;0;0;False;0;0,0;0.001,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;222;1600,789;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;1184,1328;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;1453,1125;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;77;1839.157,784.6406;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.8;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;229;1798.836,412.8626;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;2106.1,730.4999;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;254;1852.95,1026.42;Float;True;Property;_TextureSample1;Texture Sample 1;12;0;Create;True;0;0;False;0;None;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;249;1896.004,1246.688;Float;False;Property;_Remap;Remap;11;0;Create;True;0;0;False;0;0,0,0,0;0,1,0.8,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;244;2394.753,733.4253;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;248;2373.056,1042.092;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;217;-1424,-1024;Float;False;Constant;_Vector0;Vector 0;12;0;Create;True;0;0;False;0;0,1,0,0.4;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;-992,-272;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;48;-3312,-912;Float;False;Property;_Colore;Colore;1;0;Create;True;0;0;False;0;0.3973832,0.7720588,0.7410512,0;0,0.7164218,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;215;-1120,-1664;Float;False;Property;_BlueScreen;BlueScreen;4;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;200;-3264,-2032;Float;True;Property;_TextureSample4;Texture Sample 4;6;0;Create;True;0;0;False;0;None;20be5f27c1f07cd41ad7303c5d3f3352;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;8;-2896,-1536;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.5;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;232;-1680,-112;Float;False;Constant;_Vector1;Vector 1;13;0;Create;True;0;0;False;0;0,1,-0.5,0.9;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;247;2641.598,881.1974;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;209;-1024,-1152;Float;False;Constant;_Int0;Int 0;21;0;Create;True;0;0;False;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;211;-1904,-1184;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DesaturateOpNode;230;-2000,-192;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;100;-4816,-1696;Float;False;2;0;FLOAT;0;False;1;FLOAT;1000;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-4384,-528;Float;False;Property;_RimPower;Rim Power;5;0;Create;True;0;0;False;0;5;9.7;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;243;-736,-144;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;103;-4416,-1568;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCCompareEqual;205;-704,-976;Float;False;4;0;FLOAT;0;False;1;INT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3840,-1312;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TimeNode;99;-4992,-1552;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;4;-2880,-1296;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;201;-2832,-2016;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;216;-1168,-1424;Float;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-5136,-1696;Float;False;Property;_Float3;Float 3;2;0;Create;True;0;0;False;0;5;10;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;214;-1552,-1440;Float;True;Property;_TextureSample5;Texture Sample 5;7;0;Create;True;0;0;False;0;None;5228a04ef529d2641937cab585cc1a02;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;-4752,-1408;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-1856,-704;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;45;-3312,-576;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;251;1117.199,901.0191;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;104;-4224,-1584;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;05aa43dbbeddb24419e5b5b6e734d595;05aa43dbbeddb24419e5b5b6e734d595;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;43;-4000,-544;Float;True;2;0;FLOAT;10;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;231;-1328,-176;Float;True;5;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-3040,-720;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCCompareEqual;204;-688,-1488;Float;False;4;0;FLOAT;0;False;1;INT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;241;-1296,-352;Float;False;Constant;_Color0;Color 0;14;1;[HDR];Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-4608,-1568;Float;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;246;3023.958,693.9167;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MonitorBlu_Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;1;218;0
WireConnection;222;0;76;4
WireConnection;222;1;223;0
WireConnection;21;0;220;0
WireConnection;21;1;15;2
WireConnection;19;0;226;0
WireConnection;19;1;21;0
WireConnection;77;0;222;0
WireConnection;229;0;3;0
WireConnection;54;0;229;0
WireConnection;54;1;77;0
WireConnection;254;1;19;0
WireConnection;244;0;54;0
WireConnection;248;0;254;0
WireConnection;248;1;249;1
WireConnection;248;2;249;2
WireConnection;248;3;249;3
WireConnection;248;4;249;4
WireConnection;240;0;241;0
WireConnection;240;1;231;0
WireConnection;247;1;244;0
WireConnection;247;2;248;0
WireConnection;211;0;8;0
WireConnection;100;0;98;0
WireConnection;103;0;102;0
WireConnection;103;1;101;0
WireConnection;205;0;215;0
WireConnection;205;1;209;0
WireConnection;205;2;8;0
WireConnection;205;3;216;0
WireConnection;119;0;104;0
WireConnection;201;0;200;0
WireConnection;216;0;214;0
WireConnection;216;1;217;1
WireConnection;216;2;217;2
WireConnection;216;3;217;3
WireConnection;216;4;217;4
WireConnection;45;0;119;0
WireConnection;45;1;43;0
WireConnection;104;1;103;0
WireConnection;43;1;37;0
WireConnection;231;0;230;0
WireConnection;231;1;232;1
WireConnection;231;2;232;2
WireConnection;231;3;232;3
WireConnection;231;4;232;4
WireConnection;51;0;48;0
WireConnection;51;1;45;0
WireConnection;204;0;215;0
WireConnection;204;1;209;0
WireConnection;204;2;211;0
WireConnection;204;3;55;0
WireConnection;102;0;100;0
WireConnection;102;1;99;0
WireConnection;246;2;247;0
ASEEND*/
//CHKSM=00A20AB1BFB9D53BCE0EBC39D9AC791DB37D4ECA