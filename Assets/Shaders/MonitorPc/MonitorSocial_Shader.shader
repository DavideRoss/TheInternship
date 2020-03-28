// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MonitorSocial_Shader"
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
			float4 smoothstepResult13 = smoothstep( float4( 0,0,0,0 ) , float4( 1,1,1,0 ) , tex2D( _Map, i.uv_texcoord ));
			float clampResult12 = clamp( ( _SinTime.w * _Float0 ) , 0.8 , 1.0 );
			float4 clampResult18 = clamp( ( smoothstepResult13 * clampResult12 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float2 uv_TexCoord14 = i.uv_texcoord * _Tiling + ( _Offset * _Time.y );
			float4 temp_cast_0 = (_Remap.x).xxxx;
			float4 temp_cast_1 = (_Remap.y).xxxx;
			float4 temp_cast_2 = (_Remap.z).xxxx;
			float4 temp_cast_3 = (_Remap.w).xxxx;
			float4 lerpResult21 = lerp( float4( 0,0,0,0 ) , clampResult18 , (temp_cast_2 + (tex2D( _TextureSample1, uv_TexCoord14 ) - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0)));
			o.Emission = lerpResult21.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
4;-4;1906;1011;2645.053;476.0311;1.807752;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-2032.409,-209.6752;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;4;-1744,240;Float;False;Property;_Float0;Float 0;3;0;Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;5;-1728,80;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;6;-2128,608;Float;False;Property;_Offset;Offset;1;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TimeNode;7;-2176,736;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;9;-1952,496;Float;False;Property;_Tiling;Tiling;2;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1520,144;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-1936,688;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;8;-1732.511,-229.0256;Float;True;Property;_Map;Map;0;0;Create;True;0;0;False;0;8d15ed6ab3ae42b49b3170d80aca42c2;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1664,480;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;13;-1328,-224;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;12;-1312,144;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.8;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1008,96;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;16;-1264,384;Float;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;17;-1232,608;Float;False;Property;_Remap;Remap;4;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;18;-720,96;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;19;-752,400;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;21;-480,240;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;23;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MonitorSocial_Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;5;4
WireConnection;10;1;4;0
WireConnection;11;0;6;0
WireConnection;11;1;7;2
WireConnection;8;1;3;0
WireConnection;14;0;9;0
WireConnection;14;1;11;0
WireConnection;13;0;8;0
WireConnection;12;0;10;0
WireConnection;15;0;13;0
WireConnection;15;1;12;0
WireConnection;16;1;14;0
WireConnection;18;0;15;0
WireConnection;19;0;16;0
WireConnection;19;1;17;1
WireConnection;19;2;17;2
WireConnection;19;3;17;3
WireConnection;19;4;17;4
WireConnection;21;1;18;0
WireConnection;21;2;19;0
WireConnection;23;2;21;0
ASEEND*/
//CHKSM=A65B218782C1A083CEDB1F38BC9ED8CC6A1AA20C